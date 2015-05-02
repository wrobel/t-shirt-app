//
//  JobDownload.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 29.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

class JobDownload {

    let backendUrl = Settings().backendUrl()

    var jobDownloadedDelegate: JobDownloadedDelegate
    
    init(jobDownloadedDelegate delegate: JobDownloadedDelegate) {
        jobDownloadedDelegate = delegate
    }
    
    func downloadJob(queueId: String) {
        var request = NSMutableURLRequest(URL: NSURL(string: backendUrl + queueId)!)
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request, completionHandler:{
            (data: NSData!,
            response: NSURLResponse!,
            error: NSError!) in
            if (error != nil) {
                println(error.localizedDescription)
            } else if data.length == 0 {
                println("No result yet")
                dispatch_async(dispatch_get_main_queue(), {
                  self.jobDownloadedDelegate.jobDownloaded(nil)
                })
            } else {
                println("Job result available")
                dispatch_async(dispatch_get_main_queue(), {
                    self.jobDownloadedDelegate.jobDownloaded(UIImage(data: data)!)
                })
            }
        })
        
        task.resume()
    }
}