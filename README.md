# JKNoticationHelper

[![CI Status](https://img.shields.io/travis/xindizhiyin2014/JKNoticationHelper.svg?style=flat)](https://travis-ci.org/xindizhiyin2014/JKNoticationHelper)
[![Version](https://img.shields.io/cocoapods/v/JKNoticationHelper.svg?style=flat)](https://cocoapods.org/pods/JKNoticationHelper)
[![License](https://img.shields.io/cocoapods/l/JKNoticationHelper.svg?style=flat)](https://cocoapods.org/pods/JKNoticationHelper)
[![Platform](https://img.shields.io/cocoapods/p/JKNoticationHelper.svg?style=flat)](https://cocoapods.org/pods/JKNoticationHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## summary
this tool help you to use notificaion easily,you don't need to care to removeObserver. and easy to use.

## Requirements

## Installation

JKNoticationHelper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:
#### OC:

```ruby
pod 'JKNoticationHelper'
```
#### swift:
```ruby
pod 'JKNoticationHelper_Swift'

```

### how to use

#### 1) conform the JKFastNotificationProtocol
```
class ViewController: UIViewController,JKFastNotificationProtocol {
}
```
##### 2) add Observer

```
jk_observeNotificaion(name: "aaaaa") { notification in
            print("hahah")
        }
```
#### 3) post Observer
```
jk_postNotification(notificationName: "aaaaa")

```
#### demo code 
```
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
        let person = Person()
        
       jk_postNotification(notificationName: "aaaaa")
        let vc:BViewController = BViewController()
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
```


## Author

xindizhiyin2014, 929097264@qq.com

## License

JKNoticationHelper is available under the MIT license. See the LICENSE file for more info.
