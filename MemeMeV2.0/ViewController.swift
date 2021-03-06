//
//  ViewController.swift
//  MemeMeV2.0
//
//  Created by Zach Eidenberger on 7/7/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var picker: UIBarButtonItem?
    @IBOutlet weak var camera: UIBarButtonItem?
    @IBOutlet weak var topText: UITextField?
    @IBOutlet weak var bottomText: UITextField?
    @IBOutlet weak var sharebutton: UIBarButtonItem?
    @IBOutlet weak var toolbar: UIToolbar?
    @IBOutlet weak var navBar: UINavigationBar?
    @IBOutlet weak var dismissButton: UIBarButtonItem?
    
    
    
    
    let TextFieldDelegate = TextDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        sharebutton?.isEnabled = false
        
        func configure (textfield: UITextField) {
            textfield.defaultTextAttributes = memeTextAttributes
            textfield.textAlignment = .center
            textfield.delegate = TextFieldDelegate
        }
        configure(textfield: topText!)
        configure(textfield: bottomText!)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubcribeToKeyboardNotificaitons()
        
    }
  
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: Float(-3.0)]
    
    
    
    func chooseSourceType(source: UIImagePickerControllerSourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func pickfromAlbum (sender: AnyObject) {
        chooseSourceType(source: .photoLibrary)
    }
    @IBAction func pickfromCamera (sender: AnyObject) {
        chooseSourceType(source: .camera)
    }
    
    @IBAction func dismissMemeEditor (sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareMeme (sender: AnyObject) {
        func generateMeme () -> (UIImage) {
            toolbar?.isHidden = true
            navBar?.isHidden = true
            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawHierarchy(in: (self.view.frame), afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            navBar?.isHidden = false
            toolbar?.isHidden = false
           
            
            //print(memeArray)
            
            return memedImage
        }
        
        let memedImage = generateMeme()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: [])
        self.show(activityController, sender: nil)
        
        
        
        
        
        activityController.completionWithItemsHandler = {(type: UIActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            

            func save() {
                let meme = AppDelegate.Meme(topText: (self.topText?.text)!, bottomText: (self.bottomText?.text)!, originalImage: (self.imageView?.image)!, memedImage: memedImage)
                
                let object = UIApplication.shared.delegate
                let appDelegate = object as! AppDelegate
                appDelegate.memes.append(meme)
                print(appDelegate.memes)
            }
            save()
            
        }
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView?.image = image
            sharebutton?.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    // Show Keyboard
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if (topText?.isEditing)! {
            view.frame.origin.y = 0.0
        }else {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide (_ notification: Notification) {
        
        view.frame.origin.y = 0.0
    }
    
    
    
    func subscribeToKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubcribeToKeyboardNotificaitons () {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
}






