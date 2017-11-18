//
//  ListVC.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import UIKit

class ListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //MARK: Constants
    private let reuseIdentifier = "FlickrCell"
    private let minSpacing:CGFloat = 8
    private let footerHeight:CGFloat = 50

    //MARK: Variables
    var currentItem:FlickrItem?
    var medias = [String]()
    var items = [FlickrItem]()
    var cellSize = CGSize.zero
    var isRequestSend = false, isFinished = false

    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = currentItem?.author ?? "Photos"
        let width:CGFloat = (UIScreen.main.bounds.size.width - (3 * minSpacing)) / 2
        cellSize = CGSize(width: width, height: width)
        getPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func getPhotos() {
        if !isRequestSend && !isFinished {
            isRequestSend = true
            NetworkManager.sharedManager.getPhotos(userId: currentItem?.authorId, completion: {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.addItems(from: result)
                }
            })
        }
    }
    
    private func addItems(from list:[FlickrItem]?) {
        if let l = list {
            var isItemAdded = false
            for item in l {
                if let m = item.media?.absoluteString, m.isNonEmpty, !medias.contains(m) {
                    items.append(item)
                    medias.append(m)
                    isItemAdded = true
                }
            }
            isFinished = !isItemAdded
        }
        collectionView?.reloadData()
        isRequestSend = false
    }
    
    private func openItem(_ item:FlickrItem) {
        if let itemAuthorId = item.authorId, let currentId = currentItem?.authorId, itemAuthorId == currentId {
            //You can present photo gallery if you want
        }
        else if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SID_List") as? ListVC {
            vc.currentItem = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrCell
        cell.refresh(with: items[indexPath.row])
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openItem(items[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionElementKindSectionFooter {
            getPhotos()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CRVLoading", for: indexPath)
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: isFinished ? 0 : footerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minSpacing
    }

}
