//
//  DetailViewController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 09/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import Alamofire 
import MediaPlayer
import CoreTelephony
import SystemConfiguration

class DetailViewController: UIViewController {

    var theStationDataObject: RadioData?
    var timer = Timer()
    var player: AVPlayer?
    var currentSongName: String?
    
    
    @IBOutlet weak var currentStationPlaying: UIImageView!
    @IBOutlet weak var currentSongPlaying: UILabel?
    @IBOutlet weak var playPauzeButton: UIButton!
    
    // MARK: viewController life cycle funtions.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayRadioStationImage()

        checkNetwork()
        
        let sharingButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(DetailViewController.shareCurrentStationPlaying(_:)))
        self.navigationItem.rightBarButtonItem = sharingButton
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    // Apple fixed func.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Invalidate a timer becose other wise the viewcontroller kept alive in memory!!!.
        
        timer.invalidate()
    
    }
    
    // Action button to play the StreamUrl.
    @IBAction func playButton(_ sender: Any) {
        playSong()
    }
    
    // MARK: Code for the player functions.
    func playSong() {
        let urlstring = theStationDataObject?.streamingUrl
        let url = NSURL(string: urlstring!)
        print("the url = \(url!)")
        
        if let playerLocal = self.player {
            if playerLocal.isPlaying {
                player?.pause()
                togglePlayPauze()
            } else {
                player?.play()
                togglePlayPauze()
            }
        } else {
            creatAvplayer(url: url!)
        }
    }
    
    // Function to stop the stream playing.
    func stopPlayer() {
        if let play = player {

            print("stopped")
            play.pause()
            togglePlayPauze()
            player = nil
            print("player deallocated")
        } else {
            print("player was already deallocated")
        }
    }
    
    // Function that gets the streaming url play when pressing the playButton.
    func creatAvplayer(url:NSURL) {
        print("playing \(url)")
        
        setupLockScreenPlayer()
        
        do {
            let playerItem = AVPlayerItem(url: url as URL)
            self.player = AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
            togglePlayPauze()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }

    // Toggle the play and pauze button on the detailView.
    func togglePlayPauze() {
        
        let playImage = UIImage(named: "PlayButton.png")
        let pauzeImage = UIImage(named: "PauzeButton.png")
        
        if (self.player?.isPlaying)! {
            playPauzeButton.setImage(pauzeImage, for: .normal)
            print("is pressed")
        } else {
            print("is depressed")
            playPauzeButton.setImage(playImage, for: .normal)
        }
    }

    // MARK: set currentSong and stationImage.
    
    // Function to get the url of the currentSong out of FireBase so we can display it in the detailView.
    func showCurrentSong() {
        
        // Let the current song display show below the image of radioStationUrlImage.
        if let currentSongPlayingUrl = theStationDataObject?.currentSong {
            
            //Alamofire you use for unwrapping a url and it give back the response in this case a artist and titel.
            Alamofire.request(currentSongPlayingUrl).responseString(completionHandler: { (response) in
                print(response.result.value as Any)
                if response.result.isSuccess {
                   
                    // Here you see a if condiction.
                    if let songName = response.result.value {
                        self.currentSongName = songName
                        
                        // If you find a value than display the text in the outlet currentSongPlaying.
                        self.currentSongPlaying?.text = songName
                    }
                } else {
                    // Create the alert controller
                    let alert = UIAlertController(title: "Streaming error", message: "please try again later while we try to fix this for you", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                        print("you have pressed the Cancel button")
                    }))
                    self.present(alert, animated: true, completion:nil)
                }
                
                self.setMetaData()
            })
        }
    }
    
    func displayRadioStationImage() {
        
        // Let the image url of FireBase get in to the detailView.
        if let radioStationUrlImage = theStationDataObject?.stationImage {
            let url = URL(string: radioStationUrlImage)
            self.currentStationPlaying.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "247logo"))
        }

    }
    
    // MARK: lockScreen functions.
    
    func setupLockScreenPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            //sets class up to listen for lockscreen / remoteControlReceived.
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch {
                print(error)
            }
                } catch {
                    print(error)
        }
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        print(event!.type)
        if event!.type == UIEventType.remoteControl {
            if event?.subtype == UIEventSubtype.remoteControlPlay {
                playSong()
            } else if event?.subtype == UIEventSubtype.remoteControlPause {
                player?.pause()
            }
        }
    }
    
    func setMetaData() {
        if let song = currentSongName {
            let lockScreenImage: UIImageView = UIImageView()
            if let radioStationUrlImage = theStationDataObject?.stationImage {
                let url = URL(string: radioStationUrlImage)
                lockScreenImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (stationPlaying, error, cache, url) in
                    let artworkProperty = MPMediaItemArtwork.init(boundsSize: .init(width: 100, height: 100) ,requestHandler: { (size) -> UIImage in
                        
                        return lockScreenImage.image!
                    })
                    
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle : song,
                                                                       MPMediaItemPropertyArtwork : artworkProperty,
                                                                       MPNowPlayingInfoPropertyDefaultPlaybackRate : NSNumber(value: 1),
                                                                       MPMediaItemPropertyPlaybackDuration : CMTimeGetSeconds((self.player!.currentItem?.asset.duration)!)]
                })
            }
        }
    }
    
    // Sharing button on deatailView and functionality.
    func shareCurrentStationPlaying(_ sender: UIBarButtonItem) {
        
        if let stringUrl = theStationDataObject?.sharingUrl,
            let myWebsite = NSURL(string: (stringUrl)),
            let title = (theStationDataObject?.stationName),
            let shareCurrentSong = currentSongName {
            
                let textToShare = "Join me and listen to \n\"\(shareCurrentSong)\" on \(title)!"
        
                let objectsToShare = [textToShare, myWebsite] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                activityVC.popoverPresentationController?.sourceView = sender.customView
                self.present(activityVC, animated: true, completion: nil)
                    
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let activityViewController = UIActivityViewController(activityItems: [title as Any, description, image], applicationActivities: nil)
                                         activityViewController.excludedActivityTypes = [UIActivityType.assignToContact]
                                         activityViewController.completionWithItemsHandler = {
                                         (activityType, completed, returnedItems, activityError) in
                                         self.dismiss(animated: true, completion: nil)
            }
        
            picker.present(activityViewController, animated: true)
        
        }
    
    func checkNetwork() {

        if UserDefaults.standard.bool(forKey: userDefaultKeys.wifiCheck) == false && currentReachabilityStatus != .reachableViaWiFi{
        
            // Create the alert controller
            let Networkalert = UIAlertController(title: "Warning", message: "You are not on wifi, this app will use your mobile data. Is this ok? ", preferredStyle: UIAlertControllerStyle.alert)
                Networkalert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                self.playSong()
                self.showCurrentSong()
                self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.showCurrentSong), userInfo: nil, repeats: true)
                UserDefaults.standard.set(true, forKey: userDefaultKeys.wifiCheck)
            }))
                
            Networkalert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(Networkalert, animated: true, completion: nil)
        } else {
            self.playSong()
            self.showCurrentSong()
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(showCurrentSong), userInfo: nil, repeats: true)
        }

    }
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
}




