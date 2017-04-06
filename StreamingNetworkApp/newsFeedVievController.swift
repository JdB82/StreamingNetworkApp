//
//  newsFeedVievController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 27/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit

class newsFeedVievController: UIViewController {

    @IBOutlet weak var newsOutlet: UIWebView?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: "https://www.facebook.com/247streaming");
        let requestObj = NSURLRequest(url: url! as URL);
        newsOutlet?.loadRequest(requestObj as URLRequest);
        
        }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        if(newsOutlet?.canGoBack)! {
            newsOutlet?.goBack()
            } else {
                self.navigationController?.popViewController(animated:true)
            }
    }
    
    @IBAction func forwardBtn(_ sender: Any) {
    
        if(newsOutlet?.canGoForward)! {
            newsOutlet?.goForward()
            } else {
                self.navigationController?.popViewController(animated:true)
        }
    }
}
