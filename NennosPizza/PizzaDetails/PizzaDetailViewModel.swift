//
//  PizzaDetailViewModel.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Combine
import Foundation
import PizzaEngine

class PizzaDetailViewModel {
    
    lazy var ingredientsCellViewModel = createIngredientCellViewModels()
    lazy var pizzaName = pizzaIngredientsViewModel.pizzaViewModel.pizza.name.uppercased()

    let pizzaIngredientsViewModel: PizzaIngredientsViewModel
    private let cart: Cart!

    init(
        pizzaIngredientsViewModel: PizzaIngredientsViewModel,
        cart: Cart
    ) {
        self.pizzaIngredientsViewModel = pizzaIngredientsViewModel
        self.cart = cart
    }

    func addPizzaToCart() {
        let pizza = PizzaCartItem(
            pizza: pizzaIngredientsViewModel.pizzaViewModel.pizza,
            price: pizzaIngredientsViewModel.pizzaViewModel.price
        )
        cart.addItem(pizza)
        MessageUtility.showAddedToCartMessage()
    }
}

private extension PizzaDetailViewModel {
    
    func createIngredientCellViewModels() -> [IngredientCellViewModel] {
        let pizzaIngredients = Set(pizzaIngredientsViewModel.pizzaViewModel.pizza.ingredients)
        
        let ingredientCellViewModels = pizzaIngredientsViewModel.allIngredients.map { ingredient in
            let isIngredientAdded = pizzaIngredients.contains(ingredient.id)
            let title = ingredient.name
            let price = "\(AppConstants.appCurrencySymbol)\(ingredient.price)"
            
            return IngredientCellViewModel(
                title: title,
                price: price,
                isIngredientAdded: isIngredientAdded
            )
        }
        
        return ingredientCellViewModels
    }
}
