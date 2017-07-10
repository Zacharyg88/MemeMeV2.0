//
//  SentMemesCollectionViewController.swift
//  MemeMeV2.0
//
//  Created by Zach Eidenberger on 7/7/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
class SentMemesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var sentMemeImageView: UIImageView!
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridMeme", for: indexPath) 
        
        let image = appDelegate.memes [(indexPath as NSIndexPath).item]
        
        sentMemeImageView.image = image.memedImage
        
        return cell
    }
    
}
