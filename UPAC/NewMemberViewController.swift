//
//  NewMemberViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/2/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

class NewMemberViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var positionField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var pictureView: UIImageView!
    
    var boardTable: UITableView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func chooseMemberPicture() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    // Show image picker for member photo
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in })
        
        var mask = pictureView.layer
        mask.cornerRadius = pictureView.frame.size.width / 2
        mask.masksToBounds = true
        pictureView.image = image
        
    }
    
    func saveMember() {
        var name = nameField.text
        var position = positionField.text
        var email = emailField.text
        
        boardMgr.addMember(name,
            position: position,
            email: email,
            picture: UIImageJPEGRepresentation(pictureView.image, 0.7))
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        var errorMsg: String? = validateInput()
        if let errorMsg = errorMsg {
            var errorAlert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .Alert)
            errorAlert.view.tintColor = UIColor.blueColor()
            
            var ok = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in }
            errorAlert.addAction(ok)
            
            // Need to wrap presentation to prevent warning
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
            
        } else {
            saveMember()
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    //TODO: make sure an image has been selected
    func validateInput() -> String? {
        var result: String?
        
        if nameField.text      != "" &&
            positionField.text != "" &&
            emailField.text    != "" {
                result = nil
        } else {
            result = "All fields are required"
        }
        
        return result
    }
    
    override func viewDidDisappear(animated: Bool) {
        boardTable.reloadData()
    }
    
}
