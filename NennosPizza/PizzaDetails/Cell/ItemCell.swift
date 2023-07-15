//
//  ItemCell.swift
//  NennosPizza
//
//  Created by Abin Baby on 13.07.23.
//

import UIKit

enum CellType {
    case ingredientCell
    case drinkCell
    case cartItemCell
}

class ItemCell: UITableViewCell {
    
    @IBOutlet private weak var accessoryImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    // MARK: Igredient Cell
    func configureIngredientCell(with itemCellViewModel: IngredientCellViewModel) {
        titleLabel.text = itemCellViewModel.title
        priceLabel.text = itemCellViewModel.price
        accessoryImageView.isHidden = !itemCellViewModel.isIngredientAdded
    }

    // MARK: Cart Cell

    func configureCartCell(with cartItem: CartCellViewModel) {
        titleLabel.text = cartItem.title
        priceLabel.text = "\(AppConstants.appCurrencySymbol)\(cartItem.price)"
        accessoryImageView.isHidden = !Features.isCartEditingEnabled
    }

    // MARK: Drink Cell

    func configureDrinkCell(with drinkItem: DrinkCellViewModel) {
        titleLabel.text = drinkItem.title
        priceLabel.text = "\(AppConstants.appCurrencySymbol)\(drinkItem.price)"
        accessoryImageView.isHidden = false
    }
}
