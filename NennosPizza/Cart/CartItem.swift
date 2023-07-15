//
//  CartItem.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation
import PizzaEngine

protocol CartItem {
    var price: Double { get }
}

struct PizzaCartItem: CartItem {
    
    let pizza: Pizza
    let price: Double
}

struct DrinkCartItem: CartItem {
    
    let drink: Drink
    let price: Double
}

