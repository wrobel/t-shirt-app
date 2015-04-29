//
//  JobQueue.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 28.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

class JobQueue {

    private let queueFileName = "queue.plist"
    
    private func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true
        )
        let documentsDirectory = paths[0] as! NSString
        return documentsDirectory.stringByAppendingPathComponent(queueFileName) as String
    }

    func storeNewJob(job: String) {
        job.writeToFile(self.dataFilePath(), atomically: true, encoding: NSUTF8StringEncoding)
        println("Stored: " + job)
    }
    
    func loadActiveJob() -> String? {
        let filePath = self.dataFilePath()
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            let queueId = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)!
            println("Loaded: " + queueId)
            return queueId
        }
        return nil
    }
}