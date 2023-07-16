//
//  MockPizzaService.swift
//  NennosPizzaTests
//
//  Created by Abin Baby on 16.07.23.
//



@testable import NennosPizza
import PizzaEngine

class MockPizzaRepository: PizzaServiceFetchable {
    var fetchPizzasResult: Result<PizzasInfo, Error> = .success(PizzasInfo(basePrice: 0.0, pizzas: []))
    var fetchPizzasFailureResult: Result<PizzasInfo, Error> = .failure(MockError.mockError)
    var fetchIngredientsResult: Result<[Ingredient], Error> = .success([])
    var fetchIngredientsFailureResult: Result<[Ingredient], Error> = .failure(MockError.mockError)
    var fetchDrinksResult: Result<[Drink], Error> = .failure(MockError.mockError)

    func fetchPizzas() async throws -> PizzasInfo {
        switch fetchPizzasResult {
        case .success(let pizzasInfo):
            return pizzasInfo
        case .failure(let error):
            throw error
        }
    }

    func fetchIngredients() async throws -> [Ingredient] {
        switch fetchIngredientsResult {
        case .success(let ingredients):
            return ingredients
        case .failure(let error):
            throw error
        }
    }

    func fetchDrinks() async throws -> [Drink] {
        switch fetchDrinksResult {
        case .success(let drinks):
            return drinks
        case .failure(let error):
            throw error
        }
    }
}

enum MockError: Error {
    case mockError
}
