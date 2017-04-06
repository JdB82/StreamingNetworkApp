//
//  newsFeedVievController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 27/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit
import SVProgressHUD

class newsFeedVievController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var newsOutlet: UIWebView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        newsOutlet?.delegate = self
        
        if let url = URL(string: "http://www.247streamingblog.wordpress.com") {
            let requestObj = NSURLRequest(url: url)
            newsOutlet?.loadRequest(requestObj as URLRequest)
        }
        
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
    
    // Web view delegate functions
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()

    }
}
