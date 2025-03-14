//
//  Extensions.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 14/1/21.
//  Copyright © 2021 GrameenPhone Ltd. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    /// Fix for http://stackoverflow.com/a/27153956/849645
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        if #available(iOS 13.0, *) {
            // In iOS 13 we don't want to remove the transition view as it'll create a blank screen
        } else {
            // The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
    
}


extension UIApplication {
    class var topViewController: UIViewController? {
        return UIWindow.key?.rootViewController?.topMostViewController()
    }
    
    /// this var returns the top most presented Controller
    /// which is suitable for top layer alert, toast, modal, etc
    class var topPresentedViewController: UIViewController? {
        if var topController = UIWindow.key?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}

extension UIViewController {
    
    func topMostViewController() -> UIViewController {
        
        if let navController = self as? UINavigationController,
           let visibleVC = navController.visibleViewController {
            return visibleVC.topMostViewController()
        }
        
        if let tabController = self as? UITabBarController {
            if let selectedVC = tabController.selectedViewController {
                return selectedVC.topMostViewController()
            }
            //return tabController.topMostViewController()
        }
        
        if let presentedVC = self.presentedViewController {
            return presentedVC.topMostViewController()
        }
        
        return self
    }
}

extension URL {
    
    static func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
        
    }
}


extension NavigationLink where Label == EmptyView, Destination == EmptyView {

   /// Useful in cases where a `NavigationLink` is needed but there should not be
   /// a destination. e.g. for programmatic navigation.
   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}


