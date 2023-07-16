//
//  ItemCellViewModel.swift
//  NennosPizza
//
//  Created by Abin Baby on 13.07.23.
//

import Foundation

protocol ItemCellViewModelProtocol {
    var cellType: CellType { get }
    var title: String { get }
    var price: String { get }
}


struct IngredientCellViewModel: ItemCellViewModelProtocol {
    let cellType: CellType = .ingredientCell
    let title: String
    let price: String
    let isIngredientAdded: Bool
}

struct CartCellViewModel: ItemCellViewModelProtocol {
    let cellType: CellType = .cartItemCell
    let title: String
    let price: String
}

struct DrinkCellViewModel: ItemCellViewModelProtocol {
    let cellType: CellType = .drinkCell
    let title: String
    let price: String
}
