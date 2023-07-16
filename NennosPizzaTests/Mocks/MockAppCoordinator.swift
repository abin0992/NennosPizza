//
//  MockAppCoordinator.swift
//  NennosPizzaTests
//
//  Created by Abin Baby on 16.07.23.
//
@testable import NennosPizza

class MockAppCoordinator: MainCoordinatable {
    var showPizzaListCalled = false
    var showPizzaDetailsCalled = false
    var showCartCalled = false
    var showDrinksListCalled = false

    func showPizzaList() {
        showPizzaListCalled = true
    }

    func showPizzaDetails(pizzaViewModel: PizzaIngredientsViewModel) {
        showPizzaDetailsCalled = true
    }

    func showCart() {
        showCartCalled = true
    }

    func showDrinksList() {
        showDrinksListCalled = true
    }
}
