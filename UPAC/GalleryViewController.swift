//
//  GalleryViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

var __galleryCollectionView: UICollectionView? = nil

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet var picturesCollectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        __galleryCollectionView = picturesCollectionView
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
        picturesCollectionView.addSubview(refreshControl)
    }
    
    func refresh() {
        galleryMgr.getFBPictures() { void in self.refreshControl.endRefreshing() }
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
    
    func getAppropriateCellSize() -> CGFloat {
        return (self.view.frame.width / 3) - 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(getAppropriateCellSize(), getAppropriateCellSize())
    }
    
    // Size of sections
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryMgr.list.count
    }

    // Set cell content
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if !galleryMgr.list.isEmpty {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as UICollectionViewCell
            
            dispatch_async(dispatch_get_main_queue()) {
                (cell.contentView.viewWithTag(1) as UIImageView).image =  UIImage(data: (galleryMgr.list[indexPath.row] as Picture).data)

            }
            
            cell.frame.size.width = getAppropriateCellSize()
            cell.frame.size.height = getAppropriateCellSize()

            return cell
        } else {
            return collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as UICollectionViewCell
        }
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
