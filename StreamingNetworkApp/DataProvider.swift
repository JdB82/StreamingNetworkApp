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


    var ref: FIRDatabaseReference!
    
// 12-3 try some stuff out here.
    
    // Singleton: jttps://en.wikipedia.org/wiki/Singleton_pattern
    private init() {}
    
    public func getRadioData() {
        ref = FIRDatabase.database().reference() //Stores a link to firebase for your database.

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dataDictionarys = snapshot.value as? NSDictionary,
                    let dataArray = dataDictionarys[radioDictionaryKey] as? NSArray,
                    let radioModelArray = RadioData.modelsFromDictionaryArray(array: dataArray) as? [RadioData] {
                    
                        // 3. I changed the key that we use here (the "path to child" string)
                        print(radioModelArray)
                        
    //                    let radioDataArray = radiodataDict.allValues
    //                    _ = RadioData.modelsFromDictionaryArray(array: radioDataArray as NSArray)
    //                    
                        let stationinformation = [radioDictionaryKey: radioModelArray]
                        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationChannel),
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

  }
}

