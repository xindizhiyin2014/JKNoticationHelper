//
//  BViewController.swift
//  JKNoticationHelper_Swift_Example
//
//  Created by JackLee on 2021/9/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import JKNoticationHelper_Swift
class BViewController: UIViewController,JKFastNotificationProtocol {
    override func viewDidLoad() {
        view.backgroundColor = .blue
        jk_observeNotificaion(name: "oooo") { notification in
            print("llll")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
