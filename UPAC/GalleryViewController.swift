//
//  GalleryViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

var __galleryCollectionView: UICollectionView? = nil

class GalleryViewController: UICollectionViewController {
    @IBOutlet var picturesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        __galleryCollectionView = picturesCollectionView
    }
    
    // Number of sections
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if galleryMgr.list.count < 1 {
            var noDataLabel = UILabel()
            noDataLabel.text = "No data is currently available. Pull down to refresh."
            noDataLabel.textAlignment = .Center
            noDataLabel.numberOfLines = 0
            noDataLabel.sizeToFit()
            
            picturesCollectionView.backgroundView = noDataLabel
            
            return 0
        } else {
            picturesCollectionView.backgroundView = nil
            
            return 1
        }
    }
    
    // Size of sections
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryMgr.list.count
    }
    
    // Set cell content
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as UICollectionViewCell
        
        dispatch_async(dispatch_get_main_queue()) {
            (cell.contentView.viewWithTag(1) as UIImageView).image =  UIImage(data: (galleryMgr.list[indexPath.row] as Picture).data)

        }
                
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
            
            var indexPath:NSIndexPath = self.picturesCollectionView.indexPathForCell(sender as UICollectionViewCell)!
            
            destinationView.picture = galleryMgr.list[indexPath.row] as Picture
            destinationView.index = indexPath.row
        }
    }
    
    
}
