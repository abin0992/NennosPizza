//
//  Cart.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Combine
import Foundation

// MARK: - CartProtocol

protocol CartProtocol {
    var items: [CartItem] { get }
    var totalPrice: Double { get }

    func addItem(_ item: CartItem)
    func removeItem(_ item: CartItem)
    func clearCartItems()
}

// MARK: - Cart

class Cart: CartProtocol {
    @Published private(set) var cartItems: [CartItem] = []

    var items: [CartItem] {
        cartItems
    }

    var totalPrice: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }

    func addItem(_ item: CartItem) {
        cartItems.append(item)
    }

    func removeItem(_ item: CartItem) {
        // TODO: Add logic to support edit cart
    }

    func clearCartItems() {
        cartItems.removeAll()
    }
}
