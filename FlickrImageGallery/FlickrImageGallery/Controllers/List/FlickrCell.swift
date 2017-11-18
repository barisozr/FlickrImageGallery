//
//  FlickrCell.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import UIKit

class FlickrCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    func refresh(with item:FlickrItem) {
        labelAuthor.text = item.author
        labelDate.text = item.publishedDate?.toString()
        //TO-DO: Download image
    }
}
