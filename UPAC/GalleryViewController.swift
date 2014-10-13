//
//  GalleryViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet var picsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        picsCollectionView!.collectionViewLayout = layout
        picsCollectionView!.registerClass(CollectionViewImageCell.self, forCellWithReuseIdentifier: "CollectionViewImageCell")
    }
    
    // UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryMgr.pics.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as CollectionViewImageCell
        
        //cell.backgroundColor = UIColor.greenColor()
        cell.imageView?.image = UIImage(named: galleryMgr.pics[indexPath.row].img)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // PLACEHOLDER--------
        let alert: UIAlertView = UIAlertView()
        let title = galleryMgr.pics[indexPath.row].description
        let date = NSDateFormatter.localizedStringFromDate(galleryMgr.pics[indexPath.row].date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        let img = galleryMgr.pics[indexPath.row].img
        alert.title = title
        alert.message = "\(date)\n\(img)"
        alert.addButtonWithTitle("Ok")
        alert.show()
        // --------------------
        
        //TODO: Switch to new view showing full-sized image
    }

}