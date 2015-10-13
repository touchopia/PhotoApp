//
//  HomeViewController.swift
//  CameraApp
//
//  Created by Phil Wright on 10/13/15.
//  Copyright © 2015 Touchopia, LLC. All rights reserved.
//

import UIKit
import PermissionScope

class HomeViewController: UIViewController {

    let pscope = PermissionScope()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pscope.headerLabel.text = "Iron Yard"
        pscope.bodyLabel.text = "We would like some permissions"
        
        pscope.addPermission(PhotosPermission(), message: "We need to use access your Photo Gallery")
        
        pscope.show({(finished, results) -> Void in
            
            // results as PermissionResult
            
        }, cancelled: { (results) -> Void in
            
            // Cancel Button was Pressed
        })

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        super.viewWillAppear(animated)
    }

}
