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

class DetailViewController: UIViewController {

    var theStationDataObject: RadioData?
    

    var player: AVPlayer?
    var isPressed = false
    
    @IBOutlet weak var currentStationPlaying: UIImageView!
    @IBOutlet weak var currentSongPlaying: UILabel?
    @IBOutlet weak var playPauzeButton: UIButton!

    // Action button to play the StreamUrl.
    @IBAction func playButton(_ sender: Any) {
        let urlstring = theStationDataObject?.streamingUrl
        let url = NSURL(string: urlstring!)
        print("the url = \(url!)")
        // image state
        togglePlayPauze()
        
        if let playerLocal = self.player {
            if playerLocal.isPlaying {
                stopPlayer()
            }
        } else {
//            play(url: url!)
        }
    }
    
    // Function to stop the stream playing.
    func stopPlayer() {
        if let play = player {
            print("stopped")
            play.pause()
            player = nil
            print("player deallocated")
        } else {
            print("player was already deallocated")
        }
    }
    
    // Toggle the play and pauze button on the detailView.
    func togglePlayPauze() {
        
        let playImage = UIImage(named: "Play.png")
        let pauzeImage = UIImage(named: "Pause.png")
        
        if isPressed {
            playPauzeButton.setImage(pauzeImage, for: .normal)
            print("is pressed")
            isPressed = false
        } else if !isPressed {
            print("is depressed")
            playPauzeButton.setImage(playImage, for: .normal)
            isPressed = true
        }
    }

    
    // Function to get the url of the currentSong out of FireBase so we can display it in the detailView.
    func showCurrentSong() {
        let currentSongUrl = theStationDataObject?.currentSong
        let songUrl = NSURL(string: currentSongUrl!)
        print("the Url = \(songUrl)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        togglePlayPauze()
        
        // Let the image url of FireBase get in to the detailView.
        if let radioStationUrlImage = theStationDataObject?.stationImage {
            let url = URL(string: radioStationUrlImage)
            self.currentStationPlaying.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "247logo"))
        }
        
        // Let the current song display show below the image of radioStationUrlImage.
        if let currentSongPlayingUrl = theStationDataObject?.currentSong {
            //Alamofire you use for unwrapping a url and it give back the response in this case a artist and titel.
            Alamofire.request(currentSongPlayingUrl).responseString(completionHandler: { (response) in
                print(response.result.value as Any)
                    if let songName = response.result.value {
                        self.currentSongPlaying?.text = songName
                }
            })
        }
    
    // Apple fixet func.
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function that gets the streaming url play when pressing the playButton. 
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
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
        
        do {
            let playerItem = AVPlayerItem(url: url as URL)
            self.player = AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  }
}
