//
//  StreamingNetworkAppUITests.swift
//  StreamingNetworkAppUITests
//
//  Created by Jeroen de Bie on 08/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import XCTest

class StreamingNetworkAppUITests: XCTestCase {
        
    func testExample() {
        // 1
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
//        // 2
//        let chipCountTextField = app.textFields["chip count"]
//        chipCountTextField.tap()
//        chipCountTextField.typeText("10")
//        // 3
//        let bigBlindTextField = app.textFields["big blind"]
//        bigBlindTextField.tap()
//        bigBlindTextField.typeText("100")
        // 4
        snapshot("stationScreen")
        // 5
//        app.buttons["what should i do"].tap()
        //snapshot("02Suggestion")
    }
    
}
