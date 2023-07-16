//
//  PizzaRepository.swift
//  NennosPizza
//
//  Created by Abin Baby on 11.07.23.
//

import Combine
import Foundation
import PizzaEngine

// MARK: - PizzaServiceFetchable

protocol PizzaServiceFetchable {
    func fetchPizzas() async throws -> PizzasInfo
    func fetchIngredients() async throws -> [Ingredient]
    func fetchDrinks() async throws -> [Drink]
}

// MARK: - PizzaRepository

class PizzaRepository: PizzaServiceFetchable {
    // TODO: The local database fetching should go in here

    private let pizzaService: PizzaService = .init()

    func fetchPizzas() async throws -> PizzasInfo {
        do {
            let pizzas = try await pizzaService.fetchPizzas()
            return pizzas
        } catch {
            throw PEError.generic
        }
    }

    func fetchIngredients() async throws -> [Ingredient] {
        do {
            let ingredients = try await pizzaService.fetchIngredients()
            return ingredients
        } catch {
            throw PEError.generic
        }
    }

    func fetchDrinks() async throws -> [Drink] {
        do {
            let drinks = try await pizzaService.fetchDrinks()
            return drinks
        } catch {
            throw PEError.generic
        }
    }
}
