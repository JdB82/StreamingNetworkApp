//
//  StartViewController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 31/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    var radioStationData: [RadioData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        radioStationData = radioDictionary[radioDictionaryKey]!
        NotificationCenter.default.removeObserver(StartViewController.notifyObservers)

        self.performSegue(withIdentifier: ToCollectionViewSeque, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ToCollectionViewSeque {
            
            let goToCollectionView = segue.destination as! CollectionViewController
                        goToCollectionView.radioStationData = radioStationData
        }
    }

}
