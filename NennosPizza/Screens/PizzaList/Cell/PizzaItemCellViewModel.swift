//
//  PizzaItemCellViewModel.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation
import PizzaEngine

struct PizzaItemCellViewModel {
    let pizza: Pizza
    let ingredients: [Ingredient]
    let ingredientsString: String
    let price: Double
}
