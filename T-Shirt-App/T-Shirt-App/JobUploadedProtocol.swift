//
//  JobUploadedProtocol.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 28.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

protocol JobUploadedDelegate {
    func jobCreated(queueId: String)
}