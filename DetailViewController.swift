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

class DetailViewController: UIViewController {
    
    var theStationPlaying: RadioData?
    var player: AVPlayer?
    
    @IBOutlet weak var currentStationPlaying: UIImageView!
    
    @IBAction func playButton(_ sender: Any) {
        let urlstring = theStationPlaying?.streamingUrl
        let url = NSURL(string: urlstring!)
        print("the url = \(url!)")
        
        play(url: url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let radioStationUrlImage = theStationPlaying?.stationImage {
            let url = URL(string: radioStationUrlImage)
            self.currentStationPlaying.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "247logo"))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play(url:NSURL) {
        print("playing \(url)")
        
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
