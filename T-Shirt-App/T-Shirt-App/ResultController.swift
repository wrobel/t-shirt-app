//
//  ResultController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 29.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class ResultController: UIViewController {

    private var result: UIImage?

    @IBOutlet var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayResultImage(result: UIImage) {
        self.result = result
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }

    func updateDisplay() {
        if let currentResult = result {
            println("Displaying result image")
            println(currentResult)
            if imageView != nil {
                imageView.image = currentResult
                imageView.hidden = false
            } else {
                println("Image View nil")
            }
        } else {
            println("Has no result")
            imageView.hidden = true
        }
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
