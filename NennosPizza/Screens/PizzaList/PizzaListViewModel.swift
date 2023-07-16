//
//  PizzaListViewModel.swift
//  NennosPizza
//
//  Created by Abin Baby on 11.07.23.
//

import Combine
import Foundation
import PizzaEngine

// MARK: - PizzaListViewModelProtocol

protocol PizzaListViewModelProtocol {
    var isLoading: Bool { get set }
    var isApiErrorOccured: Bool { get set }
    var pizzaViewModels: [PizzaItemCellViewModel] { get set }

    func loadData() -> AnyPublisher<Void, Error>
    func addPizzaToCart(index: IndexPath)
    func didSelectItem(at index: Int)
    func showCartItems()
}

// MARK: - PizzaListViewModel

class PizzaListViewModel: PizzaListViewModelProtocol {
    @Published var isLoading: Bool = true
    @Published var isApiErrorOccured: Bool = false
    @Published var pizzaViewModels: [PizzaItemCellViewModel] = []

    var pizzaBasePrice: Double = 0.0
    private var pizzas: [Pizza] = []
    var ingredients: [Ingredient] = []

    private let pizzaRepository: PizzaServiceFetchable!
    private let appCoordinator: MainCoordinatable!
    private let cart: CartProtocol!

    init(
        pizzaRepository: PizzaServiceFetchable = PizzaRepository(),
        appCoordinator: MainCoordinatable,
        cart: CartProtocol
    ) {
        self.pizzaRepository = pizzaRepository
        self.appCoordinator = appCoordinator
        self.cart = cart
    }

    func loadData() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [unowned self] promise in
            Task {
                do {
                    try await self.fetchIngredients()
                    try await self.fetchPizzas()
                    self.calculatePizzaViewModels()
                    promise(.success(()))
                } catch {
                    self.isLoading = false
                    // TODO: check error type and show error message accordingly
                    self.isApiErrorOccured = true
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func addPizzaToCart(index: IndexPath) {
        let selectedPizza = pizzaViewModels[index.row]
        let pizza = PizzaCartItem(
            pizza: selectedPizza.pizza,
            price: selectedPizza.price
        )
        cart.addItem(pizza)
        MessageUtility.showAddedToCartMessage()
    }
}

// MARK: navigation

extension PizzaListViewModel {
    func didSelectItem(at index: Int) {
        let selectedItem = pizzaViewModels[index]
        let pizzaIngredientsViewModel = PizzaIngredientsViewModel(
            allIngredients: ingredients.sorted(),
            pizzaViewModel: selectedItem
        )
        appCoordinator.showPizzaDetails(pizzaViewModel: pizzaIngredientsViewModel)
    }

    func showCartItems() {
        appCoordinator.showCart()
    }

    func ingredientsForPizza(_ pizza: Pizza) -> ([Ingredient], String) {
        let ingredients = ingredients.filter { pizza.ingredients.contains($0.id) }
        let ingredientNames = ingredients.map { $0.name }
        return (ingredients, ingredientNames.joined(separator: ", "))
    }

    func calculatePrice(_ pizza: Pizza) -> Double {
        let ingredientPrices = pizza.ingredients.compactMap { ingredientId in
            ingredients.first { $0.id == ingredientId }?.price
        }
        let totalIngredientPrice = ingredientPrices.reduce(0, +)
        return pizzaBasePrice + totalIngredientPrice
    }
}

private extension PizzaListViewModel {
    func fetchIngredients() async throws {
        ingredients = try await pizzaRepository.fetchIngredients()
    }

    func fetchPizzas() async throws {
        let pizzasInfo = try await pizzaRepository.fetchPizzas()
        pizzaBasePrice = pizzasInfo.basePrice
        pizzas = pizzasInfo.pizzas
    }

    // MARK: Pizza cell viewmodels

    func calculatePizzaViewModels() {
        isLoading = false
        pizzaViewModels = pizzas.map { pizza in
            let ingredients = ingredientsForPizza(pizza)
            let price = calculatePrice(pizza)
            return PizzaItemCellViewModel(
                pizza: pizza,
                ingredients: ingredients.0,
                ingredientsString: ingredients.1,
                price: price
            )
        }
    }
}
