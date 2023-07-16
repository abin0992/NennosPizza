//
//  UIViewController+ClassName.swift
//  NennosPizza
//
//  Created by Abin Baby on 15.07.23.
//

import Foundation
import UIKit
extension UIViewController {
    static var className: String {
        String(describing: self)
    }
}
