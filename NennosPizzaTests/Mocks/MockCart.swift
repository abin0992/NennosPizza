//
//  MockCart.swift
//  NennosPizzaTests
//
//  Created by Abin Baby on 16.07.23.
//

@testable import NennosPizza

class MockCart: CartProtocol {
    var items: [CartItem] = []
    var totalPrice: Double = 0.0
    var addItemCalled = false
    var removeItemCalled = false
    var clearCartItemsCalled = false

    func addItem(_ item: CartItem) {
        addItemCalled = true
        items.append(item)
    }

    func removeItem(_ item: CartItem) {
       // TODO: add cart editing feature
    }

    func clearCartItems() {
        clearCartItemsCalled = true
        items.removeAll()
    }
}
