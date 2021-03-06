//
//  MainNavigationController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 14/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    //Changes the color off the navigationBar items.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        customNavigationBar()

        // Do any additional setup after loading the view.
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

    func customNavigationBar() {
        
        navigationBar.barTintColor = GlobalParams.navigation.barTintColor
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Termina-Black", size: 17)!,
            NSForegroundColorAttributeName : UIColor.white]
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationBar.clipsToBounds = false
    }

}
