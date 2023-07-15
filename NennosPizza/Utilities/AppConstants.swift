//
//  AppConstants.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import Foundation

struct Alert {
    static let retryButtonLabel: String = "Retry"
    static let okButtonLabel: String = "Ok"
    static let errorTitle: String = "Oops 🙁"
    static let unknownErrorTitle: String = "Something went wrong 🙁"
    static let invalidUrlTitle: String = "Invalid URL"
    static let invalidUrlMessage: String = "The url attached to this user is invalid."
    static let addedToCart: String = "ADDED TO CART"
}

struct Storyboards {
    static let main: String = "main"
}

struct PizzaListColors {
    static let navigationBarTintColor: String = "NavBarTintColor"
}

struct AppConstants {
    static let appCurrencySymbol: String = "$"
}

enum Features {
    static let isCartEditingEnabled: Bool = false
}
