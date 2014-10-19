//
//  GalleryViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

class GalleryViewController: UICollectionViewController {
    
    @IBOutlet var picsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Number of sections
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Size of sections
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryMgr.pics.count
    }
    
    // Set cell content
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as UICollectionViewCell
        
        (cell.contentView.viewWithTag(1) as UIImageView).image = UIImage(named: galleryMgr.pics[indexPath.row].src)
        
        return cell
    }
    
    // On-selection functionality
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //self.presentViewController(ImageViewController(), animated: true, completion: nil)
    }

    // Pass data to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FullImageView") {
            var destinationView:ImageViewController = segue.destinationViewController as ImageViewController
            var indexPath:NSIndexPath = self.picsCollectionView.indexPathForCell(sender as UICollectionViewCell)!
            
            destinationView.imgId = galleryMgr.pics[indexPath.row].id
        }
    }
    
    
}
