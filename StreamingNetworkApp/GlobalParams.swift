//
//  File.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 28-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Foundation

struct GlobalParams {
    
    // Main Settings
    struct main {
        static var title = "247 Streaming"
    }
    // Navigation Settings
    struct navigation {
 
        static var barTintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    struct tabBar {
        static let tabTextPosition = UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
    }
    
//    struct Appearance {
//        static func setGlobalAppearance() {
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().barTintColor = .green
//            UINavigationBar.appearance().isTranslucent = false
//            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//        }
//    }
}
