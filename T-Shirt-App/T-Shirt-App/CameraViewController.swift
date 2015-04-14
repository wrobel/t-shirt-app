//
//  CameraViewController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 14.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,
        UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet var imageView:UIImageView!
    
    @IBOutlet var takePictureButton:UIButton!
    
    @IBAction func shootPicture(sender: UIButton) {
        // This should be UIImagePickerControllerSourceType.Camera but does not work with simulator
        // Leave on PhotoLibrary until testing for real
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType) {
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)!
        let picker = UIImagePickerController()
        picker.mediaTypes = mediaTypes
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = sourceType
        presentViewController(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
