//
//  ViewController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 08/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

// Import your UI frameworks.
import UIKit
import Kingfisher
import FirebaseDatabase


// Implement the protocols I need.
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    // make a var of the nam radioStationData where I store the array [RadioData]
    var radioStationData: [RadioData] = []
    // creating a property.
    var currentRadioStation: RadioData?
    
    
    // Make a var imageView.
//    var imageView = [RadioData].stationImage
    
    @IBOutlet weak var radioCollectionView: UICollectionView!
    @IBOutlet weak var myLabel: UILabel!
    
    // MARK: viewDidLoad.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = GlobalParams.main.title
        
        let nib = UINib(nibName: collectionViewXib , bundle: nil)
        self.radioCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Register to receive notification data // Hieronder stemt Notification af op het keywoord "RadioDatanotify".
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CollectionViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: notificationChannel),
                                               object: nil)
        
        DataProvider.sharedInstance.getRadioData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func notifyObservers(notification: NSNotification) {
        var radioDictionary: Dictionary<String,[RadioData]> = notification.userInfo as! Dictionary<String,[RadioData]>
        radioStationData = radioDictionary[radioDictionaryKey]!
        
        radioCollectionView.reloadData()
    }
    
    // MARK:  UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return radioStationData.count
        
            }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell.
        // Put in your station image from KF in the cells.
        if let radioStationUrlImage = radioStationData[indexPath.row].stationImage {
            let url = URL(string: radioStationUrlImage)
            cell.stationImages.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "247logo"))
        }
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 45
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        currentRadioStation = radioStationData[indexPath.row]
        
        // handle tap events
        performSegue(withIdentifier: detailSeque, sender: self)
        print("You selected cell #\(indexPath.item)!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSeque {
            let detailView = segue.destination as! DetailViewController
            detailView.theStationPlaying = currentRadioStation
        }
    }
    
}




