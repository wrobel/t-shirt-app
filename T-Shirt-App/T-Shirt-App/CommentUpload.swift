//
//  CommentUpload.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 02.05.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

class CommentUpload {
    
    let backendUrl = Settings().backendUrl()
    
    func post(comment: String, job: String) {
        var request = NSMutableURLRequest(URL: NSURL(string: backendUrl + "comment")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var params = ["job": job, "comment": comment] as Dictionary<String, String>
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)

        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request, completionHandler: nil)
        
        task.resume()
    }
}