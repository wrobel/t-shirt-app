//
//  RootViewController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 28.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, JobUploadedDelegate {

    private var jobQueue: JobQueue!
    private var queueId: String?

    private var cameraController: CameraViewController!
    private var currentJobController: CurrentJobViewController!
    //private var paymentController: PaymentViewController!

    private let cameraControllerId = "camera"
    private let currentJobControllerId = "current-job"
    private let paymentControllerId = "payment"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        jobQueue = JobQueue()
        queueId = jobQueue.loadActiveJob()

        if queueId == nil {
            createCameraController()
            switchViewController(from: nil, to: cameraController)
        } else {
            createCurrentJobController()
            switchViewController(from: nil, to: currentJobController)
        }
    }

    func jobCreated(queueId: String) {
        self.jobQueue.storeNewJob(queueId)
    }

    private func createCameraController() {
        if cameraController?.view.superview == nil {
            if cameraController == nil {
                cameraController = storyboard?.instantiateViewControllerWithIdentifier(cameraControllerId) as CameraViewController
            }
        }
        cameraController.jobUpload = JobUpload(jobUploadDelegate: self)
    }
    
    private func createCurrentJobController() {
        if currentJobController?.view.superview == nil {
            if currentJobController == nil {
                currentJobController = storyboard?.instantiateViewControllerWithIdentifier(currentJobControllerId) as CurrentJobViewController
            }
        }
    }
    
    private func switchViewController(from fromVC:UIViewController?, to toVC:UIViewController?) {
        if fromVC != nil {
            fromVC!.willMoveToParentViewController(nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        
        if toVC != nil {
            toVC!.view.frame = view.frame
            
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, atIndex: 0)
            toVC!.didMoveToParentViewController(self)
        }
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
