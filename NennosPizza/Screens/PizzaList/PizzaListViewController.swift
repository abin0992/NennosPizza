//
//  PizzaListViewController.swift
//  NennosPizza
//
//  Created by Abin Baby on 11.07.23.
//

import Combine
import UIKit

// MARK: - PizzaListViewController

class PizzaListViewController: UIViewController, Storyboardable, Loadable {

    @IBOutlet private weak var pizzaListTableView: UITableView!
    @IBOutlet private weak var showCartItemsButton: UIBarButtonItem!
    @IBOutlet private weak var addCustomPizzaButton: UIBarButtonItem!

    var viewModel: PizzaListViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
        setNavigationBarButtons()
    }
}

private extension PizzaListViewController {
    func setupTableView() {
        pizzaListTableView.dataSource = self
        pizzaListTableView.delegate = self
    }

    func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.showLoadingView()
                } else {
                    self?.dismissLoadingView()
                }
            }
            .store(in: &cancellables)

        viewModel.loadData()
            .receive(on: DispatchQueue.main)
            .catch { error -> Just<Void> in
                // TODO: better error handling
                return Just<Void>(())
            }
            .sink { [weak self] _ in
                self?.pizzaListTableView.reloadData()
            }
            .store(in: &cancellables)


        viewModel.$isApiErrorOccured
            .filter { $0 == true }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.showAlertWithRetry {
                    _ = self?.viewModel.loadData()
                }
            }
            .store(in: &cancellables)
    }

    func setNavigationBarButtons() {
        showCartItemsButton.target = self
        showCartItemsButton.action = #selector(showCartItems)
        addCustomPizzaButton.isHidden = !Features.isCartEditingEnabled
    }

    @objc
    func showCartItems() {
        viewModel.showCartItems()
    }
}

// MARK: UITableViewDataSource

extension PizzaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pizzaViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaItemCell", for: indexPath) as? PizzaItemCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.pizzaViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate

extension PizzaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}

// MARK: PizzaItemCellDelegate

extension PizzaListViewController: PizzaItemCellDelegate {
    func addToCartButtonTapped(in cell: PizzaItemCell) {
        guard let indexPath = pizzaListTableView.indexPath(for: cell) else {
            return
        }
        viewModel.addPizzaToCart(index: indexPath)
    }
}
