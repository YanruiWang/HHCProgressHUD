//
//  ViewController.swift
//  HUD_Demo
//
//  Created by 王彦睿 on 2016/12/30.
//  Copyright © 2016年 家健文化传媒. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var hud:ProgressHUD = {
        return ProgressHUD(view: self.view)
    }()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: self.view.frame, style: .plain)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        UITableView.appearance().backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                                         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            hud.show(animated: true, type: .indeterminate, message: "", duration: ProgressDuration.forever)
        case 1:
            hud.show(animated: true, type: .indeterminate, message: "", duration: 3.0)
        case 2:
            hud.show(animated: true, type: .indeterminate, message: "Loading...", duration: ProgressDuration.forever)
        case 3:
            hud.show(animated: true, type: .indeterminate, message: "Loading...", duration: 3.0)
        case 4:
            hud.show(animated: true, type: .text, message: "i am a message", duration: ProgressDuration.forever)
        case 5:
            hud.show(animated: true, type: .text, message: "i am a message", duration: 3.0)
        case 6:
            hud.show(animated: true, type: .success, message: "", duration: ProgressDuration.forever)
        case 7:
            hud.show(animated: true, type: .success, message: "", duration: 3.0)
        case 8:
            hud.show(animated: true, type: .success, message: "success", duration: 3.0)
        case 9:
            hud.hide(animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell  = UITableViewCell()
        }
        cell!.textLabel?.textAlignment = .center
        switch indexPath.row {
        case 0:
            cell!.textLabel?.text = "菊花"
        case 1:
            cell!.textLabel?.text = "菊花，3秒后消失"
        case 2:
            cell!.textLabel?.text = "菊花+文字"
        case 3:
            cell!.textLabel?.text = "菊花+文字，3秒消失"
        case 4:
            cell!.textLabel?.text = "单独文字"
        case 5:
            cell!.textLabel?.text = "单独文字，3秒消失"
        case 6:
            cell!.textLabel?.text = "成功"
        case 7:
            cell!.textLabel?.text = "成功，3秒消失"
        case 8:
            cell!.textLabel?.text = "成功+文字，3秒消失"
        case 9:
            cell!.textLabel?.text = "消失"
        default:
            break
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
}

