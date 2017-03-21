//
//  AvPlayerExtension.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 20/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
