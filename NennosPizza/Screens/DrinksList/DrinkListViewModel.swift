//
//  DrinkListViewModel.swift
//  NennosPizza
//
//  Created by Abin Baby on 14.07.23.
//

import Combine
import Foundation
import PizzaEngine

class DrinkListViewModel {

    @Published var isLoading: Bool = true
    @Published var error: Error?
    @Published var drinkViewModels: [DrinkCellViewModel] = []

    private var drinks: [Drink] = []
    private let pizzaRepository: PizzaServiceFetchable!
    private let cart: Cart!

    init(
        pizzaRepository: PizzaServiceFetchable = PizzaRepository(),
        cart: Cart
    ) {
        self.pizzaRepository = pizzaRepository
        self.cart = cart
    }

    func loadData() -> AnyPublisher<Void, Never> {
        // TODO: Add cache for drinks array or cache JSON response
        return Future<Void, Never> { [unowned self] promise in
            Task {
                do {
                    try await self.fetchDrinks()
                    promise(.success(()))
                } catch {
                    self.isLoading = false
                    //
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: navigation
extension DrinkListViewModel {

    func didSelectItem(at index: Int) {
        let selectedItem = drinks[index]
        let drinkItem = DrinkCartItem(
            drink: selectedItem,
            price: selectedItem.price
        )
        cart.addItem(drinkItem)
        MessageUtility.showAddedToCartMessage()
    }
}

private extension DrinkListViewModel {
    //MARK: Drink cell viewmodels
    func fetchDrinks() async throws {
        drinks = try await pizzaRepository.fetchDrinks()
        isLoading = false
        drinkViewModels = drinks.map { drink in
            return DrinkCellViewModel(
                title: drink.name,
                price: String(drink.price)
            )
        }
    }
}