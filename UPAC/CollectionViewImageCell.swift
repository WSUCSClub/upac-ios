//
//  CollectionViewImageCell.swift
//  UICollectionView
//
//  Created by Marquez, Richard A on 10/12/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class CollectionViewImageCell: UICollectionViewCell {

    let imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGrayColor()

        imageView = UIImageView(frame: CGRect(x: 3, y: 3, width: frame.size.width - 6, height: frame.size.height - 6))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageView)
    }
    
}
