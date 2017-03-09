//
//  DataProvider.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 09/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataProvider {

    public static let sharedInstance = DataProvider()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern

        private init() { // Singleton: jttps://en.wikipedia.org/wiki/Singleton_pattern
        }

        var ref: FIRDatabaseReference!

    public func getRadioData() {
        ref = FIRDatabase.database().reference()
    
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.value as? NSArray) != nil {
                
            } else {
                print("Error while retrieving data from Firebase")
            }
        })
  }
}

