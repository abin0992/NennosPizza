//
//  PizzaListViewModelTests.swift
//  NennosPizzaTests
//
//  Created by Abin Baby on 16.07.23.
//

import XCTest
import Combine
@testable import NennosPizza
import PizzaEngine

class PizzaListViewModelTests: XCTestCase {
    var subjectUnderTest: PizzaListViewModel!
    var mockPizzaRepository: MockPizzaRepository!
    var mockAppCoordinator: MockAppCoordinator!
    var mockCart: MockCart!

    let testPizzas: [Pizza] = [
        Pizza(
            ingredients: [1, 2],
            name: "Margherita",
            imageUrl: "https://doclerlabs.github.io/mobile-native-challenge/images/pizza_PNG44095.png"
        ),
        Pizza(
            ingredients: [1, 3, 5],
            name: "Ricci e Asparagi",
            imageUrl: "https://doclerlabs.github.io/mobile-native-challenge/images/pizza_PNG44066.png"
        )
    ]

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

    override func setUp() {
        super.setUp()
        mockPizzaRepository = MockPizzaRepository()
        mockAppCoordinator = MockAppCoordinator()
        mockCart = MockCart()
        
        subjectUnderTest = PizzaListViewModel(
            pizzaRepository: mockPizzaRepository,
            appCoordinator: mockAppCoordinator,
            cart: mockCart
        )
        subjectUnderTest.pizzaBasePrice = 4.0
        subjectUnderTest.ingredients = testIngredients
    }

    func test_LoadData_Successful() {
        // Given
        
        let pizzaInfo = PizzasInfo(
            basePrice: 4.0,
            pizzas: testPizzas
        )
        
        mockPizzaRepository.fetchIngredientsResult = .success(testIngredients)
        mockPizzaRepository.fetchPizzasResult = .success(pizzaInfo)
        var completionCalled = false
        
        // When
        let expectation = self.expectation(description: "Loading data")
        let cancellable = subjectUnderTest.loadData()
            .sink(receiveCompletion: { completion in
                if case .finished = completion {
                    completionCalled = true
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
        
        waitForExpectations(timeout: 5, handler: nil)

        // Then
        XCTAssertTrue(completionCalled)
        XCTAssertFalse(subjectUnderTest.isLoading)
        XCTAssertFalse(subjectUnderTest.isApiErrorOccured)
    }

    func test_LoadData_Failure() {
        // Given
        mockPizzaRepository.fetchIngredientsResult = .failure(MockError.mockError)
        mockPizzaRepository.fetchPizzasResult = .failure(MockError.mockError)

        var completionCalled = false

        // When
        let expectation = self.expectation(description: "Loading data")
        let cancellable = subjectUnderTest.loadData()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    completionCalled = true
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
        
        waitForExpectations(timeout: 5, handler: nil)

        // Then
        XCTAssertTrue(completionCalled)
        XCTAssertFalse(subjectUnderTest.isLoading)
        XCTAssertTrue(subjectUnderTest.isApiErrorOccured)
    }

    func test_AddPizzaToCart() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let pizzaViewModel = PizzaItemCellViewModel(
            pizza: testPizzas[0],
            ingredients: [],
            ingredientsString: "",
            price: 10.0
        )
        subjectUnderTest.pizzaViewModels = [pizzaViewModel]

        // When
        subjectUnderTest.addPizzaToCart(index: indexPath)

        // Then
        XCTAssertEqual(mockCart.items.count, 1)
        guard let firstCartItem = mockCart.items.first as? PizzaCartItem else {
            XCTFail("First cart item should be Pizza")
            return
        }
        XCTAssertEqual(firstCartItem.pizza.name, "Margherita")
        XCTAssertEqual(firstCartItem.price, 10.0)
    }

    func test_IngredientsForPizza() {
        // Given
        let pizza = testPizzas[1]

        // When
        let result = subjectUnderTest.ingredientsForPizza(pizza)

        // Then
        XCTAssertEqual(result.0.count, 3)
        XCTAssertTrue(result.0.contains(where: { $0.id == 1 }))
        XCTAssertTrue(result.0.contains(where: { $0.id == 3 }))
        XCTAssertEqual(result.1, "Mozzarella, Salami, Ricci")
    }

    func test_CalculatePrice() {
        // Given
        let pizza = testPizzas[0]

        // When
        let result = subjectUnderTest.calculatePrice(pizza)

        // Then
        XCTAssertEqual(result, 5.5)
    }
}

