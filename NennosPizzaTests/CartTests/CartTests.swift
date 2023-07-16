//
//  CartTests.swift
//  NennosPizzaTests
//
//  Created by Abin Baby on 16.07.23.
//

@testable import NennosPizza
import PizzaEngine
import XCTest

class CartTests: XCTestCase {
    var cart: Cart!

    let testPizza = Pizza(
        ingredients: [1, 3, 5],
        name: "Ricci e Asparagi",
        imageUrl: nil
    )

    override func setUp() {
        super.setUp()
        cart = Cart()
    }

    override func tearDown() {
        cart = nil
        super.tearDown()
    }

    func test_AddItem() {
        // Create a mock cart item
        let pizza = testPizza
        let pizzaCartItem = PizzaCartItem(pizza: pizza, price: 10.5)

        // Add the item to the cart
        cart.addItem(pizzaCartItem)

        // Check if the item has been added to the cart
        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items[0].price, pizzaCartItem.price)
    }

    func test_ClearCartItems() {
        // Create mock cart items
        let pizza = testPizza
        let pizzaCartItem = PizzaCartItem(pizza: pizza, price: 10.5)
        let drink = Drink(price: 1, name: "Beer", id: 2)
        let drinkCartItem = DrinkCartItem(drink: drink, price: 1)

        // Add the items to the cart
        cart.addItem(pizzaCartItem)
        cart.addItem(drinkCartItem)

        // Clear the cart items
        cart.clearCartItems()

        // Check if the cart is empty
        XCTAssertEqual(cart.items.count, 0)
    }

    func test_TotalPrice() {
        // Create mock cart items
        let pizza = testPizza
        let pizzaCartItem = PizzaCartItem(pizza: pizza, price: 10.5)
        let drink = Drink(price: 1, name: "Beer", id: 2)
        let drinkCartItem = DrinkCartItem(drink: drink, price: 1)

        // Add the items to the cart
        cart.addItem(pizzaCartItem)
        cart.addItem(drinkCartItem)

        // Check if the total price is calculated correctly
        XCTAssertEqual(cart.totalPrice, 11.5)
    }
}
