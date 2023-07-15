//
//  CartViewController.swift
//  NennosPizza
//
//  Created by Abin Baby on 13.07.23.
//

import Combine
import UIKit

class CartViewController: UIViewController, Storyboardable, Loadable {

    @IBOutlet private weak var showDrinksButton: UIBarButtonItem!
    @IBOutlet private weak var cartItemsTableView: UITableView!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var checkOutButton: UIButton!

    private var orderSuccessView: UIView?

    var viewModel: CartViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBarButton()
        setupTableView()
        bindViewModel()
    }

    @IBAction func onClickCheckOut(_ sender: Any) {
        viewModel.checkOutItems()
    }
    
}
private extension CartViewController {

    func setUpNavigationBarButton() {
        showDrinksButton.target = self
        showDrinksButton.action = #selector(showDrinksList)
    }
    
    func setupTableView() {
        cartItemsTableView.dataSource = self
        cartItemsTableView.reloadData()
        cartItemsTableView.allowsSelection = false
    }

    func bindViewModel() {
        viewModel.$totalPrice
            .receive(on: DispatchQueue.main)
            .sink { [weak self] totalPrice in
                self?.totalPriceLabel.text = "\(AppConstants.appCurrencySymbol)\(totalPrice)"
                self?.updateButtonState()
            }
            .store(in: &cancellables)
    
        viewModel.$cartItemsViewModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.cartItemsTableView.reloadData()
            }
            .store(in: &cancellables)

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

        viewModel.$isOrderPlaced
            .filter { $0 == true }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.addOrderSuccessView()
            }
            .store(in: &cancellables)

        viewModel.$isApiErrorOccured
            .filter { $0 == true }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.showAlertWithRetry() {
                    self?.viewModel.checkOutItems()
                }
            }
            .store(in: &cancellables)
    }

    func updateButtonState() {
        checkOutButton.isEnabled = viewModel.totalPrice > 0
        
        if viewModel.totalPrice > 0 {
            checkOutButton.backgroundColor = UIColor(named: PizzaListColors.navigationBarTintColor)
        } else {
            checkOutButton.backgroundColor = UIColor(named: PizzaListColors.navigationBarTintColor)?.withAlphaComponent(0.5)
        }
    }

    @objc
    func showDrinksList() {
        viewModel.showDrinksList()
    }

    func addOrderSuccessView() {
        if let mainStoryboard: UIStoryboard = storyboard {
            orderSuccessView = mainStoryboard.instantiateViewController(
                withIdentifier: ThankYouViewController.className
            ).view
        }

        if let orderSuccessView{
            view.addSubview(orderSuccessView)
        }

        showDrinksButton.isHidden = true
    }
}
// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItemsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? ItemCell else {
                return UITableViewCell()
            }
        let cellViewModel = viewModel.cartItemsViewModel[indexPath.row]
        cell.configureCartCell(with: cellViewModel)
        return cell
    }
}
