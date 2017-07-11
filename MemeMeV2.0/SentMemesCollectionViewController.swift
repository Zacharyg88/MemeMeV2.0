//
//  SentMemesCollectionViewController.swift
//  MemeMeV2.0
//
//  Created by Zach Eidenberger on 7/7/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
class SentMemesCollectionViewController: UICollectionViewController {
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidAppear(_ animated: Bool) {
    collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridMeme", for: indexPath) as! SentMemeCollectionViewCell
        
        let image = appDelegate.memes [(indexPath as NSIndexPath).row]
        
        cell.collectionImageView.image = image.memedImage
        
        return cell
    }
    
}
