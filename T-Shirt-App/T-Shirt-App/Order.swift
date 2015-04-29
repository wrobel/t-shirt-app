//
//  Order.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 29.04.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

enum ShirtForm: Int {
    case Female
    case Male
}

enum ShirtSize: Int {
    case Small
    case Medium
    case Large
    case ExtraLarge
}

struct Order {
    var form: ShirtForm
    var size: ShirtSize
}