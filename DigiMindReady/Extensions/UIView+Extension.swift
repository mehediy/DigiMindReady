//
//  UIView+Extension.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 10/9/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import UIKit

extension UIView {
    var saferAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        }
        return layoutMarginsGuide
    }
    
    //MARK:- Round Corners
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat, frame: CGRect? = nil) {
        let viewFrame = frame ?? self.bounds
        let path = UIBezierPath(roundedRect: viewFrame, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.frame = viewFrame
        self.layer.mask = mask
    }
    
    func roundBottomCorners(radius: CGFloat, frame: CGRect? = nil) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            roundCorners([.bottomLeft, .bottomRight], radius: radius, frame: frame)
        }
    }
    
    func roundTopCorners(radius: CGFloat, frame: CGRect? = nil) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
            self.layer.masksToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            roundCorners([.topLeft, .topRight], radius: radius, frame: frame)
        }
    }
    
}

extension UIView {
    static let HudLoaderTag = -991
    
    func showHudLoader() {
        if let hud = self.viewWithTag(UIImageView.HudLoaderTag) as? UIActivityIndicatorView {
            hud.startAnimating()
            return
        } else {
            var hud: UIActivityIndicatorView
            if #available(iOS 13.0, *) {
                hud = UIActivityIndicatorView(style: .medium)
            } else {
                hud = UIActivityIndicatorView(style: .gray)
            }
            hud.tag = UIImageView.HudLoaderTag
            hud.hidesWhenStopped = true
            hud.center = center
            addSubview(hud)
            bringSubviewToFront(hud)
            hud.startAnimating()
        }
    }
    
    func hideHudLoader() {
        if let hud = self.viewWithTag(UIImageView.HudLoaderTag) as? UIActivityIndicatorView {
            hud.stopAnimating()
            return
        }
    }
}

