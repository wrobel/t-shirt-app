//
//  JobDownload.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 29.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

class JobDownload {

    var jobDownloadedDelegate: JobDownloadedDelegate
    
    init(jobDownloadedDelegate delegate: JobDownloadedDelegate) {
        jobDownloadedDelegate = delegate
    }
    
    func downloadJob(queueId: String) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8000/" + queueId)!)
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
            } else {
                self.jobDownloadedDelegate.jobDownloaded(UIImage(data: data)!)
            }
        })
        
        task.resume()
    }
}