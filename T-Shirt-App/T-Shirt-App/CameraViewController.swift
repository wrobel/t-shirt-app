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

    var jobUpload: JobUpload!
    
    @IBOutlet var imageView:UIImageView!
    
    @IBOutlet var takePictureButton:UIButton!
    
    @IBOutlet var uploadButton:UIButton!

    var image:UIImage?
    
    @IBAction func shootPicture(sender: UIButton) {
        // This should be UIImagePickerControllerSourceType.Camera but does not work with simulator
        // Leave on PhotoLibrary until testing for real
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func selectImageFromLibrary(sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType) {
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)!
        let picker = UIImagePickerController()
        picker.mediaTypes = mediaTypes
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = sourceType
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        image = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateDisplay() {
        if (image != nil) {
            imageView.image = image!
            imageView.hidden = false
            uploadButton.hidden = false
        } else {
            imageView.hidden = true
            uploadButton.hidden = true
        }
    }
    
    @IBAction func uploadImage(sender: UIButton) {
        if image != nil {
            jobUpload.uploadJob(image!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            takePictureButton.hidden = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
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
