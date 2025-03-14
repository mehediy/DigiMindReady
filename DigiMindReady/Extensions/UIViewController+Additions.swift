//
//  UIViewController+Additions.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 6/7/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func delay(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    
    func showAlert(message: String, withTitle title: String? = nil, buttonTitle: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
    
    func showError(error: NSError) {
        showAlert(message: error.localizedDescription, withTitle: "Error")
    }
    
    

    /**
     returns true only if the viewcontroller is presented.
     */
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            if let parent = parent, !(parent is UINavigationController || parent is UITabBarController) {
                return false
            }
            return true
        } else if let navController = navigationController, navController.presentingViewController?.presentedViewController == navController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
}
