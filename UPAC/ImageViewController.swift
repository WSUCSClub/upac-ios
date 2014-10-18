//
//  ImageViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/12/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

//TODO: Seque from GalleryViewController; show full-sized image view and back button

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var fullImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: get image from presented view controller
        fullImage.image = UIImage(named: "spin")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
