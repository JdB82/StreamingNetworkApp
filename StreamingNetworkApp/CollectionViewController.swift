//
//  ViewController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 08/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    // Chances done 12-3.
    var radioStationData: [RadioData] = []
    
    @IBOutlet weak var 247Blitz: UILabel!
    
    
    // MARK:  UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.radioStationData[RadioData] //Put in your own array!
        cell.backgroundColor = UIColor.black
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 50
        // make cell more visible in our example project
        
        return cell
    }
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    // MARK: viewDidLoad.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Chances made 12-3.
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellReuseIdentifier: "MyCollectionViewCell")
        
        // Register to receive notification data // Hieronder stemt Notification af op het keywoord "BucketWishesnotify".
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CollectionViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: "RadioDatanotify" ),
                                               object: nil)
        
        DataProvider.sharedInstance.getRadioData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func notifyObservers(notification: NSNotification) {
        var bucketlistDictionary: Dictionary<String,[RadioData]> = notification.userInfo as! Dictionary<String,[RadioData]>
        radioStationData = bucketlistDictionary["RadioData"]!
        
        // collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}




