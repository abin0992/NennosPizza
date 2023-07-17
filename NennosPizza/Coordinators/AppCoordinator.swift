//
//  AppCoordinator.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation
import UIKit

// MARK: - MainCoordinatable

protocol MainCoordinatable {
    func showPizzaList()
    func showPizzaDetails(pizzaViewModel: PizzaIngredientsViewModel)
    func showCart()
    func showDrinksList()
}

// MARK: - AppCoordinator

class AppCoordinator: Coordinator {
    // MARK: - Properties

    private var navigationController: UINavigationController = .init()
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

// MARK: MainCoordinatable

extension AppCoordinator: MainCoordinatable {
    func showPizzaList() {
        let pizzaListViewController = PizzaListViewController.instantiate()
        let pizzaListViewModel = PizzaListViewModel(
            appCoordinator: self,
            cart: cart
        )
        pizzaListViewController.viewModel = pizzaListViewModel
        navigationController.pushViewController(pizzaListViewController, animated: true)
    }

    func showPizzaDetails(pizzaViewModel: PizzaIngredientsViewModel) {
        let pizzaDetailViewController = PizzaDetailViewController.instantiate()
        let pizzaDetailViewModel = PizzaDetailViewModel(
            pizzaIngredientsViewModel: pizzaViewModel,
            cart: cart
        )
        pizzaDetailViewController.viewModel = pizzaDetailViewModel

        navigationController.pushViewController(pizzaDetailViewController, animated: true)
    }

    func showCart() {
        let cartViewController = CartViewController.instantiate()
        let cartViewModel = CartViewModel(
            appCoordinator: self,
            cart: cart
        )
        cartViewController.viewModel = cartViewModel

        navigationController.pushViewController(cartViewController, animated: true)
    }

    func showDrinksList() {
        let drinksViewController = DrinksListViewController.instantiate()
        let drinksListViewModel = DrinkListViewModel(cart: cart)
        drinksViewController.viewModel = drinksListViewModel
        navigationController.pushViewController(drinksViewController, animated: true)
    }
}

private extension AppCoordinator {
    func setUpNavigationBar() {
        navigationController.navigationBar.tintColor = UIColor(named: PizzaListColors.navigationBarTintColor)
        guard let navigationBarTintColor = UIColor(named: PizzaListColors.navigationBarTintColor) else {
            return
        }
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: navigationBarTintColor,
            .font: UIFont.systemFont(ofSize: 17, weight: .heavy)
        ]
        navigationController.navigationBar.titleTextAttributes = titleAttributes
    }
}
