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
    
    // Creates a UIColor from a Hex string.
//    func colorWithHexString (hex:String) -> UIColor {
//        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
//
//        if (countElements(cString) != 6) {
//            return UIColor.grayColor()
//        }
//        
//        var rString = cString.substringToIndex(2)
//        var gString = cString.substringFromIndex(2).substringToIndex(2)
//        var bString = cString.substringFromIndex(4).substringToIndex(2)
//        
//        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
//        NSScanner.scannerWithString(rString).scanHexInt(&r)
//        NSScanner.scannerWithString(gString).scanHexInt(&g)
//        NSScanner.scannerWithString(bString).scanHexInt(&b)
//        
//        return UIColor(red: Float(r) / 255.0, green: Float(g) / 255.0, blue: Float(b) / 255.0, alpha: Float(1))
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
