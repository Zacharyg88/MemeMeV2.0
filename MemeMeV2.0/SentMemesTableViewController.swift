//
//  SentMemesTableViewController.swift
//  MemeMeV2.0
//
//  Created by Zach Eidenberger on 7/10/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableMeme", for: indexPath)
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    func printcheck() {
        print(appDelegate.memes)
    }
}


