//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by Phil Wright on 10/13/15.
//  Copyright © 2015 Touchopia, LLC. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraImageView: UIImageView!

    let picker = UIImagePickerController()

    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self

        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
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
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }
}
