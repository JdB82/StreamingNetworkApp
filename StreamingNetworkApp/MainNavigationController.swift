//
//  MainNavigationController.swift
//  StreamingNetworkApp
//
//  Created by Jeroen de Bie on 14/03/2017.
//  Copyright © 2017 Jeroen de Bie. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            NSForegroundColorAttributeName : UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 240.0/255.0, alpha: 1.0)]
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationBar.clipsToBounds = false
    }

}
