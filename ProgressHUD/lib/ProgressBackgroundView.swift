//
//  ProgressBackground.swift
//  HHCProgressHUDSwift
//
//  Created by 王彦睿 on 2016/12/28.
//  Copyright © 2016年 家健文化传媒. All rights reserved.
//

import UIKit
import QuartzCore

public final class ProgressBackgroundView: UIView {

    var color: UIColor?
    
    var style: ProgressHUDBackgroundStyle
    
    override public init(frame: CGRect) {
        style = .solidColor
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        style = .solidColor
        super.init(coder: aDecoder)
    }

}
