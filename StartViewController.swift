//
//  StartViewController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 31/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit
import SVProgressHUD

class StartViewController: UIViewController {

    var dataReturned: [RadioData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(StartViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: notificationChannel),
                                               object: nil)
        
        DataProvider.sharedInstance.getRadioData()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func notifyObservers(notification: NSNotification) {
        var radioDictionary: Dictionary<String,[RadioData]> = notification.userInfo as! Dictionary<String,[RadioData]>
        dataReturned = radioDictionary[radioDictionaryKey]!
        radioStationData = dataReturned
        
        for (index, radioStation) in radioStationData.enumerated() {
            var tempImage: UIImageView = UIImageView.init()
            if let radioStationImage = radioStation.stationImage {
                let url = URL(string: radioStationImage)
                tempImage.kf.setImage(with: url)
            }
        }
        SVProgressHUD.dismiss()

        self.performSegue(withIdentifier: ToCollectionViewSeque, sender: self)
        
    }

}
