//
//  ViewController.swift
//  JKNoticationHelper_Swift
//
//  Created by xindizhiyin2014 on 09/08/2021.
//  Copyright (c) 2021 xindizhiyin2014. All rights reserved.
//

import UIKit
import JKNoticationHelper_Swift
class ViewController: UIViewController,JKFastNotificationProtocol {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .red
        self.view.addSubview(button)
        button.center = self.view.center
        button.addTarget(self, action: #selector(buttonClicked), for:.touchUpInside)
        jk_observeNotificaion(name: "aaaaa") { notification in
            print("hahah")
        }
    }
    
    
    @objc func buttonClicked() ->Void {
       jk_postNotification(notificationName: "aaaaa")
        let vc:BViewController = BViewController()
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

