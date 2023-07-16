//
//  AppConstants.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation

// MARK: - Alert

struct Alert {
    static let retryButtonLabel: String = "Retry"
    static let okButtonLabel: String = "Ok"
    static let errorTitle: String = "Oops 🙁"
    static let unknownErrorTitle: String = "Something went wrong 🙁"
    static let invalidUrlTitle: String = "Invalid URL"
    static let addedToCart: String = "ADDED TO CART"
}

// MARK: - Storyboards

enum Storyboards {
    static let main: String = "main"
}

// MARK: - PizzaListColors

enum PizzaListColors {
    static let navigationBarTintColor: String = "NavBarTintColor"
}

// MARK: - AppConstants

enum AppConstants {
    static let appCurrencySymbol: String = "$"
}

// MARK: - Features

enum Features {
    static let isCartEditingEnabled: Bool = false
}
