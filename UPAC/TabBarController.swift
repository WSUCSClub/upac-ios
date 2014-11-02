//
//  TabBarViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/31/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set color of selected tab icon
        self.tabBar.tintColor = UIColor(rgb: 0x6c3987)


        // Set color of unselected tab icons
        /*for item in self.tabBar.items as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.yellowColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }*/
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
