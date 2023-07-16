//
//  DrinksListViewController.swift
//  NennosPizza
//
//  Created by Abin Baby on 14.07.23.
//

import Combine
import UIKit

class DrinksListViewController: UIViewController, Storyboardable, Loadable {

    @IBOutlet private weak var drinksTableView: UITableView!

    var viewModel: DrinkListViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
    }
}

// MARK: - UITableViewDataSource

extension DrinksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.drinkViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as? ItemCell else {
                return UITableViewCell()
            }
        let cellViewModel = viewModel.drinkViewModels[indexPath.row]
        cell.configureDrinkCell(with: cellViewModel)
        return cell
    }
}

extension DrinksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}

private extension DrinksListViewController {
    func setupTableView() {
        drinksTableView.dataSource = self
        drinksTableView.delegate = self
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
            .sink { [weak self] _ in
                self?.drinksTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
