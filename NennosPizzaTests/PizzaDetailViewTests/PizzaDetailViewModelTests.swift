//
//  PizzaDetailViewModelTests.swift
//  NennosPizzaTests
//
//  Created by Abin Baby on 16.07.23.
//

import XCTest
@testable import NennosPizza
import PizzaEngine

class PizzaDetailViewModelTests: XCTestCase {
    var subjectUnderTest: PizzaDetailViewModel!
    var pizzaIngredientsViewModel: PizzaIngredientsViewModel!
    var cart: MockCart!

    let testPizza = Pizza(
        ingredients: [1, 3, 5],
        name: "Ricci e Asparagi",
        imageUrl: nil
    )

    let testIngredients = [
        Ingredient(
            price: 1,
            name: "Mozzarella",
            id: 1
        ),
        Ingredient(
            price: 0.5,
            name: "Tomato Sauce",
            id: 2
        ),
        Ingredient(
            price: 1.5,
            name: "Salami",
            id: 3
        ),
        Ingredient(
            price: 2,
            name: "Mushrooms",
            id: 4
        ),
        Ingredient(
            price: 4,
            name: "Ricci",
            id: 5
        )
    ]

    let testPizzaItemCellViewModel = PizzaItemCellViewModel(
        pizza: Pizza(
            ingredients: [1, 3, 5],
            name: "Ricci e Asparagi",
            imageUrl: nil
        ),
        ingredients: [
            Ingredient(
                price: 1,
                name: "Mozzarella",
                id: 1
            ),
            Ingredient(
                price: 1.5,
                name: "Salami",
                id: 3
            ),
            Ingredient(
                price: 4,
                name: "Ricci",
                id: 5
            )
        ],
        ingredientsString: "Mozzarella, Salami, Ricci",
        price: 10.5
    )

    override func setUp() {
        super.setUp()
        
        
        pizzaIngredientsViewModel = PizzaIngredientsViewModel(
            allIngredients: testIngredients,
            pizzaViewModel: testPizzaItemCellViewModel
        )
        cart = MockCart()
        subjectUnderTest = PizzaDetailViewModel(
            pizzaIngredientsViewModel: pizzaIngredientsViewModel,
            cart: cart
        )
    }

    override func tearDown() {
        subjectUnderTest = nil
        pizzaIngredientsViewModel = nil
        cart = nil
        super.tearDown()
    }

    func test_AddPizzaToCart() {
        // Create a mock pizza with ingredients
        let pizza = testPizza

        // Assign the pizzaViewModel to the pizzaIngredientsViewModel
        pizzaIngredientsViewModel = PizzaIngredientsViewModel(
            allIngredients: testIngredients,
            pizzaViewModel: testPizzaItemCellViewModel
        )

        // Call the addPizzaToCart() method
        subjectUnderTest.addPizzaToCart()

        // Check if the pizza has been added to the cart
        XCTAssertEqual(cart.items.count, 1)

        // Assert that the added item matches the pizza and its price
        guard let addedPizza = cart.items.first as? PizzaCartItem else {
            XCTFail("First cart item should be Pizza")
            return
        }
        XCTAssertEqual(addedPizza.pizza.ingredients, pizza.ingredients)
        XCTAssertEqual(addedPizza.price, pizzaIngredientsViewModel.pizzaViewModel.price)
    }

    func test_IngredientsCellViewModels() {
        // Create a mock pizza with ingredients
        // testPizza
        // testPizzaItemCellViewModel


        // Assign the pizzaViewModel to the pizzaIngredientsViewModel
        pizzaIngredientsViewModel = PizzaIngredientsViewModel(
            allIngredients: testIngredients,
            pizzaViewModel: testPizzaItemCellViewModel
        )

        // Retrieve the ingredients cell view models
        let ingredientCellViewModels = subjectUnderTest.ingredientsCellViewModel
        let pizzaIngredients = Set(pizzaIngredientsViewModel.pizzaViewModel.pizza.ingredients)

        // Check if the count of ingredient cell view models matches the count of ingredients in the pizza
        XCTAssertEqual(ingredientCellViewModels.count, testIngredients.count)

        // Assert that each ingredient cell view model has the correct title, price, and isIngredientAdded flag
        for (index, ingredient) in testIngredients.enumerated() {
            let ingredientCellViewModel = ingredientCellViewModels[index]
            XCTAssertEqual(ingredientCellViewModel.title, ingredient.name)
            XCTAssertEqual(ingredientCellViewModel.price, "\(AppConstants.appCurrencySymbol)\(ingredient.price)")
            let isIngredientAdded = pizzaIngredients.contains(ingredient.id)
            XCTAssertEqual(ingredientCellViewModel.isIngredientAdded, isIngredientAdded)
        }
    }
}
