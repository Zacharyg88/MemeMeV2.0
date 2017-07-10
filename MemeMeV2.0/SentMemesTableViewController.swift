//
//  SentMemesTableViewController.swift
//  MemeMeV2.0
//
//  Created by Zach Eidenberger on 7/10/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableMeme")!
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
}


