//
//  CartViewModel.swift
//  NennosPizza
//
//  Created by Abin Baby on 14.07.23.
//

import Combine
import Foundation
import PizzaEngine

// MARK: - CartViewModel

class CartViewModel {
    @Published var totalPrice: Double = 0.0
    @Published var cartItemsViewModel: [CartCellViewModel] = []
    @Published var isLoading: Bool = false
    @Published var isOrderPlaced: Bool = false
    @Published var isApiErrorOccured: Bool = false

    private let appCoordinator: AppCoordinator!
    private let cart: Cart!
    private let checkOutService: CheckOutService = .init()

    init(
        appCoordinator: AppCoordinator,
        cart: Cart
    ) {
        self.cart = cart
        self.appCoordinator = appCoordinator
        bindViewModel()
    }
}

// MARK: Checkout service

extension CartViewModel {
    func checkOutItems() {
        isLoading = true
        let checkoutItems = createCheckOutItems()

        Task {
            do {
                _ = try await checkOutService.checkOut(items: checkoutItems)
                isLoading = false
                isOrderPlaced = true
                cart.clearCartItems()
            } catch {
                isLoading = false
                // TODO: check error type and show error message accordingly
                isApiErrorOccured = true
            }
        }
    }
}

// MARK: Navigation

extension CartViewModel {
    func showDrinksList() {
        appCoordinator.showDrinksList()
    }
}

private extension CartViewModel {
    func bindViewModel() {
        cart.$cartItems
            .map { [weak self] cartItems -> [CartCellViewModel] in
                guard let self else {
                    return []
                }
                return self.createCartCellViewModels(cartItems: cartItems)
            }
            .assign(to: &$cartItemsViewModel)

        cart.$cartItems
            .map { cartItems -> Double in
                cartItems.reduce(0) { $0 + $1.price }
            }
            .assign(to: &$totalPrice)
    }

    func createCartCellViewModels(cartItems: [CartItem]) -> [CartCellViewModel] {
        var viewModels: [CartCellViewModel] = []

        for item in cartItems {
            var title: String

            if let pizzaItem = item as? PizzaCartItem {
                title = pizzaItem.pizza.name
            } else if let drinkItem = item as? DrinkCartItem {
                title = drinkItem.drink.name
            } else {
                continue
            }

            let price = String(item.price)
            let viewModel = CartCellViewModel(title: title, price: price)
            viewModels.append(viewModel)
        }

        return viewModels
    }

    func createCheckOutItems() -> CheckOutItems {
        let pizzas: [Pizza] = cart.items.compactMap { item in
            if let pizzaItem = item as? PizzaCartItem {
                return pizzaItem.pizza
            }
            return nil
        }

        let drinks: [String] = cart.items.compactMap { item in
            if let drinkItem = item as? DrinkCartItem {
                return String(drinkItem.drink.id)
            }
            return nil
        }

        return CheckOutItems(
            pizzas: pizzas,
            drinks: drinks
        )
    }
}
