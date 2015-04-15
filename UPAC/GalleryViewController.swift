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
        galleryMgr.getFBPictures() { void in
            self.refreshControl.endRefreshing()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", forIndexPath: indexPath) as! UICollectionReusableView
        
        header.layer.borderColor = UIColor(rgb: 0xCCCCCC).CGColor
        
        var album = galleryMgr.list[indexPath.section]
        var firstPhoto = "\(album.first!.date.monthStr()) \(album.first!.date.dayNumStr())"
        var lastPhoto = "\(album.last!.date.monthStr()) \(album.last!.date.dayNumStr())"
        
        if firstPhoto != lastPhoto {
            (header.viewWithTag(1) as! UILabel).text = "\(firstPhoto) - \(lastPhoto)"
        } else {
            (header.viewWithTag(1) as! UILabel).text = firstPhoto
        }
        
        return header
    }
    
    // Number of sections
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if galleryMgr.list.count < 1 {
            var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            loadingIndicator.color = UIColor.grayColor()
            loadingIndicator.startAnimating()
            
            picturesCollectionView.backgroundView = loadingIndicator
            
            return 0
        } else {
            picturesCollectionView.backgroundView = nil
            
            return galleryMgr.list.count
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
        return galleryMgr.list[section].count
    }

    // Set cell content
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if !galleryMgr.list.isEmpty {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as! UICollectionViewCell
            
            (cell.contentView.viewWithTag(1) as! UIImageView).image =  UIImage(data: galleryMgr.list[indexPath.section][indexPath.row].data)
            
            cell.frame.size.width = getAppropriateCellSize()
            cell.frame.size.height = getAppropriateCellSize()
            
            return cell
        } else {
            return collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewImageCell", forIndexPath: indexPath) as! UICollectionViewCell
        }
    }
    
    // On-selection functionality
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //self.presentViewController(ImageViewController(), animated: true, completion: nil)
    }

    // Pass data to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FullImageView") {
            var destinationView:ImageViewController = segue.destinationViewController as! ImageViewController
            
            var indexPath:NSIndexPath = self.picturesCollectionView.indexPathForCell(sender as! UICollectionViewCell)!
            
            destinationView.album = galleryMgr.list[indexPath.section]
            destinationView.picture = galleryMgr.list[indexPath.section][indexPath.row]
            destinationView.index = indexPath.row
        }
    }
    
    
}
