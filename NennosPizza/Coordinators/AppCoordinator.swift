//
//  AppCoordinator.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation
import UIKit

protocol MainCoordinatable {
    func showPizzaList()
    func showPizzaDetails(pizzaViewModel: PizzaIngredientsViewModel)
    func showCart()
    func showDrinksList()
}

class AppCoordinator: Coordinator {

    // MARK: - Properties

    private var navigationController: UINavigationController = UINavigationController()
    private var presentingViewController: UIViewController?

    // MARK: - Public API

    var rootViewController: UIViewController {
        navigationController
    }

    private let cart = Cart()

    // MARK: - Overrides

    override func start() {
        setUpNavigationBar()
        showPizzaList()
    }
}

extension AppCoordinator: MainCoordinatable {

    func showPizzaList() {
        let pizzaListViewController: PizzaListViewController = PizzaListViewController.instantiate()
        let pizzaListViewModel = PizzaListViewModel(
            appCoordinator: self,
            cart: self.cart
        )
        pizzaListViewController.viewModel = pizzaListViewModel
        navigationController.pushViewController(pizzaListViewController, animated: true)
    }

    func showPizzaDetails(pizzaViewModel: PizzaIngredientsViewModel) {
        let pizzaDetailViewController: PizzaDetailViewController = PizzaDetailViewController.instantiate()
        let pizzaDetailViewModel = PizzaDetailViewModel(
            pizzaIngredientsViewModel: pizzaViewModel,
            cart: self.cart)
        pizzaDetailViewController.viewModel = pizzaDetailViewModel
        
        navigationController.pushViewController(pizzaDetailViewController, animated: true)
    }

    func showCart() {
        let cartViewController: CartViewController = CartViewController.instantiate()
        let cartViewModel = CartViewModel(
            appCoordinator: self,
            cart: self.cart
        )
        cartViewController.viewModel = cartViewModel
        
        navigationController.pushViewController(cartViewController, animated: true)
    }

    func showDrinksList() {
        let drinksViewController: DrinksListViewController = DrinksListViewController.instantiate()
        let drinksListViewModel = DrinkListViewModel(cart: self.cart)
        drinksViewController.viewModel = drinksListViewModel
        navigationController.pushViewController(drinksViewController, animated: true)
    }
}

private extension AppCoordinator {
    func setUpNavigationBar() {
        navigationController.navigationBar.tintColor = UIColor(named: PizzaListColors.navigationBarTintColor)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: PizzaListColors.navigationBarTintColor),
            .font: UIFont.systemFont(ofSize: 17, weight: .heavy)
        ]
        navigationController.navigationBar.titleTextAttributes = titleAttributes
    }
}
