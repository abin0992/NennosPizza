//
//  MessageUtility.swift
//  NennosPizza
//
//  Created by Abin Baby on 13.07.23.
//

import SwiftEntryKit
import UIKit

class MessageUtility {
    static func showAddedToCartMessage() {
        let text = Alert.addedToCart
        let style = EKProperty.LabelStyle(
            font: UIFont.systemFont(ofSize: 16),
            color: .white,
            alignment: .center
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        var attributes = EKAttributes.topNote
        attributes.entryBackground = .color(
            color: EKColor(
                UIColor(
                    named: PizzaListColors.navigationBarTintColor) ?? UIColor.red
            )
        )
        attributes.displayDuration = 3
        let contentView = EKNoteMessageView(with: labelContent)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
