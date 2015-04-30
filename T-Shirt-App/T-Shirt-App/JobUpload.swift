//
//  JobUpload.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 28.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

class JobUpload {

    var jobUploadedDelegate: JobUploadedDelegate
    
    init(jobUploadDelegate delegate: JobUploadedDelegate) {
        jobUploadedDelegate = delegate
    }
    
    func uploadJob(image: UIImage) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8000")!)
        request.HTTPMethod = "POST"
        let session = NSURLSession.sharedSession();
        let imageData = UIImagePNGRepresentation(image);
        let task = session.uploadTaskWithRequest(request, fromData: imageData, completionHandler:{
          (data: NSData!,
           response: NSURLResponse!,
           error: NSError!) in
            if (error != nil) {
                println(error.localizedDescription)
            } else {
                let httpResponse = response as! NSHTTPURLResponse
                let location = httpResponse.allHeaderFields["Location"] as! String
                dispatch_async(dispatch_get_main_queue(), {
                    self.jobUploadedDelegate.jobCreated(location)
                })
            }
        })
    
        task.resume()
    }
}