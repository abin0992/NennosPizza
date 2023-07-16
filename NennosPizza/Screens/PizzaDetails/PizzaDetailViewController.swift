//
//  PizzaDetailViewController.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Kingfisher
import UIKit

// MARK: - PizzaDetailViewController

class PizzaDetailViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var pizzaIngredientsTableView: UITableView!
    @IBOutlet private weak var pizzaImageView: UIImageView!
    @IBOutlet private weak var addToCartButton: UIButton!
    
    var viewModel: PizzaDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.pizzaName
        setupTableView()
        loadPizzaImage()
        configAddToCartButton()
    }

    @IBAction func onTapAddToCart(_ sender: Any) {
        viewModel.addPizzaToCart()
    }
}

private extension PizzaDetailViewController {
    func setupTableView() {
        pizzaIngredientsTableView.dataSource = self
        pizzaIngredientsTableView.reloadData()
        pizzaIngredientsTableView.allowsSelection = false
    }

    func loadPizzaImage() {
        if
            let imageUrlString = viewModel.pizzaIngredientsViewModel.pizzaViewModel.pizza.imageUrl,
            let imageUrl = URL(string: imageUrlString)
        {
            let placeHolderImage = UIImage(named: "pizza_placeholder")
            pizzaImageView.kf.setImage(
                with: imageUrl,
                placeholder: placeHolderImage
            )
        }
    }

    func configAddToCartButton() {
        let buttonTitleLabel = "ADD TO CART (\(AppConstants.appCurrencySymbol)\(viewModel.pizzaIngredientsViewModel.pizzaViewModel.price))"
        addToCartButton.setTitle(buttonTitleLabel, for: .normal)
    }
}

// MARK: UITableViewDataSource

extension PizzaDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.ingredientsCellViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.ingredientsCellViewModel[indexPath.row]
        cell.configureIngredientCell(with: cellViewModel)
        return cell
    }
}
