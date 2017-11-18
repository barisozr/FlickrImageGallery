//
//  FlickrCell.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import UIKit

class FlickrCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: Internal Methods
    func refresh(with item:FlickrItem) {
        labelAuthor.text = item.author
        labelDate.text = item.publishedDate?.toString()
        imageView.image = nil
        loadingIndicator.startAnimating()
        NetworkManager.downloadImage(url: item.media) {[weak self] (image) in
            if let img = image {
                self?.imageView.image = img
            }
            else {
                self?.imageView.image = UIImage(named: "noImage")
            }
            self?.loadingIndicator.stopAnimating()
        }
    }
}
