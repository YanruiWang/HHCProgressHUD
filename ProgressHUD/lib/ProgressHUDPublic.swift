//
//  ProgressHUDPublic.swift
//  HHCProgressHUDSwift
//
//  Created by 王彦睿 on 2017/1/3.
//  Copyright © 2017年 家健文化传媒. All rights reserved.
//

import UIKit

extension ProgressHUD {
    
    public static func showIndicator(to view: UIView, animated: Bool) {
        let hud = ProgressHUD(view: view)
        hud.showIndicator(animated: true, duration: 2.0)
    }
    
    public static func showIndicator(to view: UIView, message: String, animated: Bool) {
        let hud = ProgressHUD(view: view)
        hud.showIndicator(animated: true, with: message, duration: 2.0)
    }
    
    public static func showSuccess(to view: UIView, animated: Bool) {
        
    }
    
    public static func showSuccess(to view: UIView, message: String, animated: Bool) {
        
    }
    
    public static func showError(to view: UIView, animated: Bool) {
        
    }
    
    public static func showError(to view: UIView, message: String, animated: Bool) {
        
    }
    
    public static func show(animated: Bool) {
        
    }
    
    public static func hide(animated: Bool, after delay: TimeInterval) {
        
    }
    
    public static func hideHUD(for view: UIView) {
        
    }
    
    public static func hideHUD() {
        
    }
    
}
