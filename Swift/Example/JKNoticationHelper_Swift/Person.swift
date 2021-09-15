//
//  Person.swift
//  JKNoticationHelper_Swift_Example
//
//  Created by JackLee on 2021/9/15.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import JKNoticationHelper_Swift
public class Person:JKFastNotificationProtocol {
    init() {
        jk_observeNotificaion(name: "aaaaa") { notification in
            print("Person")
        }
    }
}
