//
//  AbortViewController.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 02.05.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import UIKit

class AbortViewController: UIViewController {

    private var jobQueue: JobQueue!
    private var commentUpload: CommentUpload!

    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        jobQueue = JobQueue()
        commentUpload = CommentUpload()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        commentField.resignFirstResponder()
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AbortJob" {
            if let job = jobQueue.loadActiveJob() {
                commentUpload.post(commentField.text, job: job)
            }
            jobQueue.clearActiveJob()
        }
    }

}
