//
//  MemeDetailViewController.swift
//  MemeMeV2.0
//
//  Created by Zach Eidenberger on 7/11/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeDetailImageView: UIImageView?
    
    var meme: UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        memeDetailImageView?.image = self.meme
    }
    
    
}
