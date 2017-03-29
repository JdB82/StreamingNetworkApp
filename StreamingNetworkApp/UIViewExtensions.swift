//
//  UIViewExtensions.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 29/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var backgroundUIColor: UIColor {
        get {
            return self.backgroundColor!
        }
        set {
            self.backgroundColor = newValue
        }
    }
}
