//
//  CartItem.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation
import PizzaEngine

// MARK: - CartItem

protocol CartItem {
    var price: Double { get }
}

// MARK: - PizzaCartItem

struct PizzaCartItem: CartItem {
    let pizza: Pizza
    let price: Double
}

// MARK: - DrinkCartItem

struct DrinkCartItem: CartItem {
    let drink: Drink
    let price: Double
}
