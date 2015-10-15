//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by Phil Wright on 10/13/15.
//  Copyright © 2015 Touchopia, LLC. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    /*
            Add the PermissionScope object as a constant
    */
    
    
    @IBOutlet weak var cameraImageView: UIImageView!

    let picker = UIImagePickerController()

    var leftButton : UIBarButtonItem?

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        /*
            Setup initial Permission Scope object (using the options)
        */
        
        

        picker.delegate = self

        leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self, action: "photofromLibrary:")

        self.navigationItem.leftBarButtonItem = leftButton

    }

    //MARK: - ImagePickerDelegate Methods

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        cameraImageView.contentMode = .ScaleAspectFit
        cameraImageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: - Action Method

    @IBAction func photofromLibrary(sender: UIBarButtonItem) {
        
        /*
            Check Photos Permissions --
        
            Show ImagePicker if Authorized or 
        
            Request Permission via PermissionScope if Not Authorized
        */
        
        
        showImagePicker()
    }
    
    func showImagePicker() {

        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = leftButton
    }
}
