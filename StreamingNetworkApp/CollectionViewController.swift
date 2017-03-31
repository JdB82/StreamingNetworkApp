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
import GoogleMobileAds

// Implement the protocols I need.
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, GADBannerViewDelegate {
    
    // make a var of the nam radioStationData where I store the array [RadioData]
    var radioStationData: [RadioData] = []
    
    // creating a property.
    var currentRadioStation: RadioData?
    
    // Constant for the Adbanner.
    @IBOutlet weak var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
    
    @IBOutlet weak var radioCollectionView: UICollectionView!
    
    // collection flow
    var itemsPerRow : CGFloat = 2
    var sectionInsets = UIEdgeInsets()

    // MARK: viewDidLoad.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate the BannerView.
        bannerView?.delegate = self
        bannerView?.adUnitID = adMobID
        bannerView?.rootViewController = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView?.load(request)
        
        self.title = GlobalParams.main.title
        
        let nib = UINib(nibName: collectionViewXib , bundle: nil)
        self.radioCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Register to receive notification data // Hieronder stemt Notification af op het keywoord "RadioDatanotify".
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CollectionViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: notificationChannel),
                                               object: nil)
        
        DataProvider.sharedInstance.getRadioData()
        
        sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
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
        if let radioStationImage = radioStationData[indexPath.row].stationImage {
            let url = URL(string: radioStationImage)
            cell.stationImages.kf.setImage(with: url)
        }
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 52
        
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
            detailView.theStationDataObject = currentRadioStation
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    // MARK: - GADBannerViewDelegate
    // Called when an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(#function): \(error.localizedDescription)")
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function)
    }
    
}



extension  CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left*2
    }
    
}


