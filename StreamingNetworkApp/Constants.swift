//
//  Constants.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 13/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import Foundation
// Make a let of the name reuseIdentifier and pass a new name cell so you cell got the same value as reuseIdentifier.
let reuseIdentifier = "MyCollectionViewCell" // also enter this string as the cell identifier in the storyboard

let notificationChannel = "RadioDatanotify"

let radioDictionaryKey = "RadioData"

let collectionViewXib = "MyCollectionViewCell"

let detailSeque = "detailSegue"

let adMobID = "ca-app-pub-7305223671398373/7805115640"

struct jsonKeys {
    static let streamingUrl = "streamingUrl"
    static let StationName  = "StationName"
    static let stationImage = "stationImage"
    static let currentSong  = "currentSong"
    static let sharingUrl   = "sharingUrl"
    
}

struct userDefaultKeys{
    static let wifiCheck = "wificheck"
}

