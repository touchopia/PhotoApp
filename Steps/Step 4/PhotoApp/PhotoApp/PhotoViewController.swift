//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by Phil Wright on 10/13/15.
//  Copyright © 2015 Touchopia, LLC. All rights reserved.
//

import UIKit
import PermissionScope

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let pscope = PermissionScope()
    
    @IBOutlet weak var cameraImageView: UIImageView!

    let picker = UIImagePickerController()

    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self

        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self, action: "photofromLibrary:")

        self.navigationItem.leftBarButtonItem = leftButton
        
        verifyPermissions()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        super.viewWillAppear(animated)
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
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    func verifyPermissions() {
        switch PermissionScope().statusPhotos() {
            
            case .Authorized:
                // Do Nothing
                return
            
            case .Unknown:
                PermissionScope().requestPhotos()
                
            case .Unauthorized, .Disabled:
                
                // Ask Again
                requestPermission()
        }
    }
    
    func requestPermission() {
        
        pscope.headerLabel.text = "Iron Yard"
        pscope.bodyLabel.text = "We would like some permissions"
        
        pscope.addPermission(PhotosPermission(), message: "In order to view your photos we need access to your photo gallery.")
        
        pscope.show({ (finished, results) -> Void in
            
            for result in results {
                if result.type == .Photos && result.status == .Authorized {
                    print("The photo gallery was authorized")
                }
            }
            
            }, cancelled: { (results) -> Void in
                
                // User Cancelled
        })
    }
}
