//
//  Extensions.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit

extension UIAlertController {
    //show alert
    class func showAlert(_ title:String?, msg:String, firstButtonText:String, secondButtonText:String? = nil, target:UIViewController?, completionFirstButton: @escaping () -> (), completionSecondButton: @escaping () -> () = {}) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: firstButtonText, style: UIAlertAction.Style.default) {
        (result: UIAlertAction) -> Void in
            completionFirstButton()
        })
        if let secondButtonText = secondButtonText {
            alert.addAction(UIAlertAction(title: secondButtonText, style: UIAlertAction.Style.cancel) {
            (result: UIAlertAction) -> Void in
                completionSecondButton()
            })
        }
        if let target = target {
            target.present(alert, animated: true, completion: nil)
        } else {
            if let topController = UIApplication.topViewController() {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension UIApplication {
    //get active screen
    public class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

extension String {
    //localizing
    var localize:String {
        return NSLocalizedString(self, comment: "")
    }
}
