//
//  PizzaItemCell.swift
//  NennosPizza
//
//  Created by Abin Baby on 11.07.23.
//

import UIKit
import Kingfisher
import PizzaEngine

class PizzaItemCell: UITableViewCell {

    @IBOutlet private weak var pizzaImageView: UIImageView!
    @IBOutlet private weak var pizzaNameLabel: UILabel!
    @IBOutlet private weak var pizzaIngredientsLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var addToCartButton: UIButton!
    
    weak var delegate: PizzaItemCellDelegate?

    func configure(with viewModel: PizzaItemCellViewModel) {
        pizzaNameLabel.text = viewModel.pizza.name
        pizzaIngredientsLabel.text = viewModel.ingredientsString
        priceLabel.text = "\(AppConstants.appCurrencySymbol)\(viewModel.price)"
        addToCartButton.addTarget(
            self,
            action: #selector(onClickAddToCart),
            for: .touchUpInside
        )
        if
            let imageUrlString = viewModel.pizza.imageUrl,
            let imageUrl = URL(string: imageUrlString)
        {
            let placeHolderImage = UIImage(named: "pizza_placeholder")
            pizzaImageView.kf.setImage(
                with: imageUrl,
                placeholder: placeHolderImage
            )
        }
    }

    @objc func onClickAddToCart() {
        delegate?.addToCartButtonTapped(in: self)
    }
}

protocol PizzaItemCellDelegate: AnyObject {
    func addToCartButtonTapped(in cell: PizzaItemCell)
}
