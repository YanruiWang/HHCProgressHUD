//
//  ProgressHUD.swift
//  HHCProgressHUDSwift
//
//  Created by 王彦睿 on 2016/12/28.
//  Copyright © 2016年 家健文化传媒. All rights reserved.
//

import UIKit



public final class ProgressHUD: UIView {

    var graceTime: TimeInterval = 0.0

    var showTime: TimeInterval = 0.0

    var minShowTime: TimeInterval = 0.0

    var removeFromSuperViewOnHide = false

    var mode: ProgressHUDMode?

    public var userCanTouchOutside = true

    /// 黑色背景 alpha = 0.6
    lazy var indicatorView: ProgressBackgroundView = {
        let indicatorView = ProgressBackgroundView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return indicatorView
    }()

    /// 菊花或图片
    var indicator: UIView  = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge) {
        didSet {
            commonInit()
        }
    }

    /// 提示信息 label
    let messageLabel = UILabel()

    /// 提示信息
    var message: String = ""

    var delayTask: DispatchWorkItem?

    public init() {
        super.init(frame: CGRect.zero)
    }


    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// - parameter view: 需要在上面显示 HUD 的 view , HUD 将显示在 view 的中间
    public init(view: UIView) {
        super.init(frame: view.frame)
        view.addSubview(self)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    fileprivate func commonInit() {
        setupUI()
        makeConstraints()
    }

    fileprivate func setupUI() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = true

        indicator.translatesAutoresizingMaskIntoConstraints = false

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
    }

    fileprivate func makeConstraints() {

        addSubview(indicatorView)
        indicatorView.addSubview(indicator)
        indicatorView.addSubview(messageLabel)

        // 黑色半透明背景
        ProgressCommon.make(view: indicatorView, inTheCenter: self)
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([indicatorView.widthAnchor.constraint(greaterThanOrEqualToConstant: 115.0)])
            NSLayoutConstraint.activate([indicatorView.widthAnchor.constraint(lessThanOrEqualToConstant: 180)])
            
            // 文字
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            let con = [messageLabel.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor),
                       messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: indicatorView.leadingAnchor, constant: 5.0),
                       messageLabel.topAnchor.constraint(greaterThanOrEqualTo: indicator.bottomAnchor, constant: 0.0),
                       messageLabel.topAnchor.constraint(greaterThanOrEqualTo: indicatorView.topAnchor, constant: 10.0),
                       messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: indicatorView.bottomAnchor, constant: -10.0)]
            con.forEach { $0.priority = 1000 }
            NSLayoutConstraint.activate(con)
            
            // 菊花或图片
            let constraints = [indicator.topAnchor.constraint(greaterThanOrEqualTo: indicatorView.topAnchor,constant: 30.0),
                               indicator.widthAnchor.constraint(equalToConstant: 45),
                               indicator.heightAnchor.constraint(equalToConstant: 45),
                               indicator.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor),
                               indicator.centerYAnchor.constraint(lessThanOrEqualTo: indicatorView.centerYAnchor)]
            constraints.forEach { $0.priority = 750 } //文字的 constraints 的优先级最高
            NSLayoutConstraint.activate(constraints)
        } else {
            NSLayoutConstraint.activate([NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 115.0)])
            NSLayoutConstraint.activate([NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 180)])
            
            // 文字
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            let con = [NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: indicatorView, attribute: .centerX, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: indicatorView, attribute: .leading, multiplier: 1, constant: 5.0),
                       NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: indicator, attribute: .bottom, multiplier: 1, constant: 0),
                       NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: indicatorView, attribute: .top, multiplier: 1, constant: 10.0),
                       NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: indicatorView, attribute: .bottom, multiplier: 1, constant: -10.0)]
            con.forEach { $0.priority = 1000 }
            NSLayoutConstraint.activate(con)
            
            // 菊花或图片
            let constraints = [NSLayoutConstraint(item: indicator, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: indicatorView, attribute: .top, multiplier: 1, constant: 30),
                               NSLayoutConstraint(item: indicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45),
                               NSLayoutConstraint(item: indicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45),
                               NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: indicatorView, attribute: .centerX, multiplier: 1, constant: 0),
                               NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .lessThanOrEqual, toItem: indicatorView, attribute: .centerY, multiplier: 1, constant: 0)]
            constraints.forEach { $0.priority = 750 } //文字的 constraints 的优先级最高
            NSLayoutConstraint.activate(constraints)
        }
        


    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return !userCanTouchOutside
    }

    fileprivate func hide(after duration: TimeInterval, animated: Bool) {
        if duration != ProgressDuration.forever {
            delayTask = DispatchWorkItem {
                self.hide(animated: animated)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: delayTask!)
        }
    }

}

// MARK: 通过枚举来判断显示类型
extension ProgressHUD {

    /// 将 HUD 显示在屏幕上
    /// - parameter animated: 出现过程中是否有动画
    /// - parameter type: HUD 类型(菊花,成功,失败,警告,纯文字)
    /// - parameter message: 需要显示的文字
    /// - parameter duration: HUD 的持续时间
    public func show(animated: Bool, type: ProgressHUDMode, message: String, duration: TimeInterval) {
        switch type {
        case .indeterminate:
            showIndicator(animated: true, with: message, duration: duration)
        case .success:
            showImage(animated: animated, name: "成功", with: message, duration: duration)
        case .failure:
            showImage(animated: animated, name: "失败", with: message, duration: duration)
        case .alert:
            showImage(animated: animated, name: "警告", with: message, duration: duration)
        case .text:
            show(message: message, duration: duration)
        }
    }

}


// MARK: "菊花"系列
extension ProgressHUD {

    /// 显示一个正在转动的"菊花".
    /// - Parameter animated: "菊花"出现的过程中是否有动画.
    public func showIndicator(animated: Bool) {
        assert(ProgressCommon.isRunningOnMainThread(), "HHCProgressHUD must run on the main thread!")
        indicator.removeFromSuperview()
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.isHidden = false
        messageLabel.isHidden = true
        indicatorView.isHidden = false
        (indicator as? UIActivityIndicatorView)?.startAnimating()
        delayTask?.cancel()
    }

    /// 显示一个正在转动的"菊花"加文字
    /// - parameter animated: "菊花"出现的过程中是否有动画
    /// - parameter with: 需要显示的文字
    public func showIndicator(animated: Bool, with message: String) {
        show(message: message)
        showIndicator(animated: animated)
        indicator.isHidden = false
        messageLabel.isHidden = false
    }

    /// 显示"菊花",并在一段时间后自动消失
    /// - parameter animated: "菊花"出现时是否有动画
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func showIndicator(animated: Bool, duration: TimeInterval) {
        showIndicator(animated: animated)
        indicator.isHidden = false
        messageLabel.isHidden = true
        hide(after: duration, animated: animated)
    }

    /// 显示一个正在转动的"菊花"加文字，并在一段时间后自动消失
    /// - parameter animated: "菊花"出现的过程中是否有动画
    /// - parameter with: 需要显示的文字
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func showIndicator(animated: Bool, with message: String, duration: TimeInterval) {
        showIndicator(animated: animated, with: message)
        indicator.isHidden = false
        messageLabel.isHidden = false
        hide(after: duration, animated: animated)
    }

    /// 显示一个正在转动的"菊花"加文字,在指定的时间后显示，并在一段时间后自动消失
    /// - parameter animated: "菊花"出现的过程中是否有动画
    /// - parameter with: 需要显示的文字
    /// - parameter after: 延迟显示的时间
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func showIndicator(animated: Bool, with message: String, after delay: TimeInterval, duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.showIndicator(animated: animated, with: message, duration: duration)
        }
    }

}

// MARK: "图片"系列
extension ProgressHUD {

    /// 显示图片
    /// - parameter animated: 出现时是否有动画
    /// - parameter name: 图片资源名称
    public func showImage(animated: Bool, name: String) {
        indicator.removeFromSuperview()
        var image = UIImage(named: name)
        if image == nil {
            let bundle = Bundle(for: type(of: self))
            image = UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        indicator = UIImageView(image: image)
        indicator.alpha = 1.0
        indicator.isHidden = false
        messageLabel.isHidden = true
        indicatorView.isHidden = false
        delayTask?.cancel()
    }

    /// 显示图片加文字
    /// - parameter animated: 出现时是否有动画
    /// - parameter name: 图片资源名称
    /// - parameter with: 显示的文字
    public func showImage(animated: Bool, name: String, with message: String) {
        show(message: message)
        showImage(animated: animated, name: name)
        indicator.isHidden = false
        messageLabel.isHidden = false
    }

    /// 显示图片加文字，并在一段时间后自动消失
    /// - parameter animated: 出现时是否有动画
    /// - parameter name: 图片资源名称
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func showImage(animated: Bool, name: String, duration: TimeInterval) {
        showImage(animated: animated, name: name)
        indicator.isHidden = false
        messageLabel.isHidden = true
        hide(after: duration, animated: animated)
    }

    /// 显示图片加文字，并在一段时间后自动消失
    /// - parameter animated: 出现时是否有动画
    /// - parameter name: 图片资源名称
    /// - parameter with: 显示的文字
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func showImage(animated: Bool, name: String, with message: String, duration: TimeInterval) {
        showImage(animated: animated, name: name, with: message)
        indicator.isHidden = false
        messageLabel.isHidden = false
        hide(after: duration, animated: animated)
    }

    /// 显示图片加文字
    /// - parameter animated: 出现时是否有动画
    /// - parameter name: 图片资源名称
    /// - parameter with: 显示的文字
    /// - parameter after: 延迟显示的时间
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func showImage(animated: Bool, name: String, with message: String, after delay: TimeInterval, duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.showImage(animated: animated, name: name, with: message, duration: duration)
        }
    }

}

// MARK: "文字"系列
extension ProgressHUD {

    /// 显示一段文字
    /// - parameter message: 需要显示的文字
    public func show(message: String) {
        assert(ProgressCommon.isRunningOnMainThread(), "HHCProgressHUD must run on the main thread!")
        messageLabel.text = message
        messageLabel.numberOfLines = 1
        indicator.isHidden = true
        messageLabel.isHidden = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = false
        delayTask?.cancel()
        indicator.removeFromSuperview()
    }

    /// 在指定的时间后显示提示文字，并在一段时间后自动消失
    /// - parameter message: 需要显示的文字
    /// - parameter after: 延迟显示的时间
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func show(message: String, duration: TimeInterval) {
        self.show(message: message)
        indicator.isHidden = true
        messageLabel.isHidden = false
        hide(after: duration, animated: true)
    }

    /// 在指定的时间后显示提示文字，并在一段时间后自动消失
    /// - parameter message: 需要显示的文字
    /// - parameter after: 延迟显示的时间
    /// - parameter duration: 文字显示的持续时间，时间结束时文字消失
    public func show(message: String, after delay: TimeInterval, duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.show(message: message, duration: duration)
        }
    }

}

// MARK: 隐藏 HUD
extension ProgressHUD {
    /// 隐藏所有的 HUD
    /// - parameter animated: 消失时是否有动画
    public func hide(animated: Bool) {
        assert(ProgressCommon.isRunningOnMainThread(), "HHCProgressHUD must run on the main thread!")
        (indicator as? UIActivityIndicatorView)?.stopAnimating()
        indicator.isHidden = true
        indicatorView.isHidden = true
    }

}
