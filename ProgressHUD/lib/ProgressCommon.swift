//
//  ProgressCommon.swift
//  HHCProgressHUDSwift
//
//  Created by 王彦睿 on 2016/12/28.
//  Copyright © 2016年 家健文化传媒. All rights reserved.
//

import UIKit

public struct ProgressDuration {
    static public let forever: TimeInterval = 0.0
}

final public class ProgressCommon {
    
    static public func isRunningOnMainThread() -> Bool {
        return Thread.isMainThread
    }
    
    static public func make(view: UIView, inTheCenter of: UIView) {
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([view.centerXAnchor.constraint(equalTo: of.centerXAnchor),
                                         view.centerYAnchor.constraint(equalTo: of.centerYAnchor)])
        } else {
            NSLayoutConstraint.activate([NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: of, attribute: .centerX, multiplier: 1, constant: 0),
                                         NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: of, attribute: .centerY, multiplier: 1, constant: 0)])
        }
    }
    
    static public func makeFixed(width: CGFloat, height: CGFloat, with view: UIView) {
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: width),
                                         view.widthAnchor.constraint(equalToConstant: height)])
        } else {
            NSLayoutConstraint.activate([NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height),
                                         NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)])
        }
    }

}

public enum ProgressHUDAnimation {
    /// Opacity animation
    case fade
    /// Opacity + scale animation (zoom in when appearing zoom out when disappearing)
    case zoom
    /// Opacity + scale animation (zoom out style)
    case zoomOut
    /// Opacity + scale animation (zoom in style)
    case zoomIn
}

public enum ProgressHUDMode {
    /// 转菊花
    case indeterminate
    /// 显示一张成功的图片
    case success
    /// 显示一张失败的图片
    case failure
    /// 显示一张警告的图片
    case alert
    /// 单独文字
    case text
}

enum ProgressHUDBackgroundStyle {
    /// Solid color background
    case solidColor
    /// UIVisualEffectView or UIToolbar.layer background view
    case blur
}

typealias ProgressHUDCompletionBlock = () -> ()
