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
    
// 12-3 try some stuff out here.
    
    public func getRadioData() -> FIRDatabaseReference {
        ref = FIRDatabase.database().reference() //Stores a link to firebase for your database.

    
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dataDictionarys = snapshot.value as? NSDictionary {
                    
                    // 3. I changed the key that we use here (the "path to child" string)
                    
                    let radiodataDict = dataDictionarys["RadioDataDict"] as! NSDictionary
                    let radioDataArray = radiodataDict.allValues
                    _ = RadioData.modelsFromDictionaryArray(array: radioDataArray as NSArray)
                    
                    let stationinformation = ["RadioData": radioDataArray]
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "RadioDatanotify"),
                                                    object: self ,
                                                    userInfo: stationinformation)
                    
                    // 1. I called the "convertData" method only once to convert the data
                    // from an array to a dictionary and put it back in Firebase
                    // on a separate key ("BucketWishesDict" instead of "BucketWishes").
                    // Compare the two data representations in the Firebase console
                    // TODO: Jeroen go to Firebase console and delete the "BucketWishes" entry (NOT the "BucketWishesDict" one!!!)
                    
                    // self.convertData(bucketlistItemsArray)
                
            } else {
                print("Error while retrieving data from Firebase")
            }
        })
        
        return ref.child("RadioDataDict")

  }
}

