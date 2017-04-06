//
//  MyTabBarController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 03/04/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This changes the colour of the icon colour.
        UITabBar.appearance().tintColor = UIColor.white
        
        //This changes the tab bars colour.
        self.tabBar.barTintColor = UIColor.black

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.barTintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
