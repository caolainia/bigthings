//
//  PromptView.swift
//  PromptView
//
//  Created by coco on 16/11/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//  在window上面显示提示view, 不影响操作

import UIKit

private let kMainScreenWidth = UIScreen.main.bounds.width
private let kMainScreenHeight = UIScreen.main.bounds.height

/// 提示view
class PromptView: UIView {
    fileprivate static let shared: PromptView = {
        let object = PromptView()
        object.addSubview(object.imageV)
        object.addSubview(object.titleL)
        object.backgroundColor = UIColor(red: 0x17 / 255.0, green: 0x17 / 255.0, blue: 0x17 / 255.0, alpha: 0.8)
        object.layer.cornerRadius = 5
        object.layer.masksToBounds = true
        return object
    }()
    
    @objc class func show(in view: UIView? = (UIApplication.shared.delegate as! AppDelegate).window,  imageName: String? = nil, message: String) {
        var inView = view
        if inView == nil {
            inView = (UIApplication.shared.delegate as! AppDelegate).window!
        }
        
        if PromptView.isShow == true {
            self.cancelPreviousPerformRequests(withTarget: self, selector: #selector(PromptView.hidden), object: nil)
            self.cancelPreviousPerformRequests(withTarget: self, selector: #selector(PromptView.show(imageName:message:)), object: nil)
        }
        let object = self.shared
        object.titleL.text = message
        object.titleL.frame.size.width = kMainScreenWidth - 60  //最大宽
        object.titleL.sizeToFit()
        if let icon = imageName {
            object.imageV.image = UIImage(named: icon)
        } else {
            object.imageV.image = nil
        }
        object.imageV.frame.size.width = kMainScreenWidth - 60  //最大宽
        object.imageV.sizeToFit()
        
        object.frame.size.width = max(object.imageV.frame.size.width, object.titleL.frame.size.width) + 40
        object.frame.size.height = object.imageV.frame.size.height + object.titleL.frame.size.height + 30
        
        object.frame.origin.x = (kMainScreenWidth - object.frame.size.width) / 2
        object.frame.origin.y = (kMainScreenHeight - object.frame.size.height) / 2
        
        object.titleL.center.x = object.frame.size.width / 2
        object.imageV.center.x = object.frame.size.width / 2
        if object.imageV.frame.size.equalTo(CGSize.zero) {
            object.titleL.frame.origin.y = 15
        } else {
            object.imageV.frame.origin.y = 10
            object.titleL.frame.origin.y = object.imageV.frame.height + object.imageV.frame.origin.y + 10
        }
        inView!.addSubview(object)
        inView!.bringSubviewToFront(object)
        object.alpha = 0
        PromptView.isShow = true
        UIView.animate(withDuration: 0.25) {
            object.alpha = 1
        }
        self.perform(#selector(PromptView.hidden), with: nil, afterDelay: 1.25)
    }
    
    /// 显示提示框, 但是可以进行UI操作
    ///
    /// - parameter imageName: 图片
    /// - parameter message:   消息
    @objc class func show(imageName: String? = nil, message: String) {
        if PromptView.isShow == true {
            self.cancelPreviousPerformRequests(withTarget: self, selector: #selector(PromptView.hidden), object: nil)
            self.cancelPreviousPerformRequests(withTarget: self, selector: #selector(PromptView.show(imageName:message:)), object: nil)
        }
        let object = self.shared
        object.titleL.text = message
        object.titleL.frame.size.width = kMainScreenWidth - 60  //最大宽
        object.titleL.sizeToFit()
        if let icon = imageName {
            object.imageV.image = UIImage(named: icon)
        } else {
            object.imageV.image = nil
        }
        object.imageV.frame.size.width = kMainScreenWidth - 60  //最大宽
        object.imageV.sizeToFit()
        
        object.frame.size.width = max(object.imageV.frame.size.width, object.titleL.frame.size.width) + 40
        object.frame.size.height = object.imageV.frame.size.height + object.titleL.frame.size.height + 30
        
        object.frame.origin.x = (kMainScreenWidth - object.frame.size.width) / 2
        object.frame.origin.y = (kMainScreenHeight - object.frame.size.height) / 2
        
        object.titleL.center.x = object.frame.size.width / 2
        object.imageV.center.x = object.frame.size.width / 2
        if object.imageV.frame.size.equalTo(CGSize.zero) {
            object.titleL.frame.origin.y = 15
        } else {
            object.imageV.frame.origin.y = 10
            object.titleL.frame.origin.y = object.imageV.frame.height + object.imageV.frame.origin.y + 10
        }
        (UIApplication.shared.delegate as! AppDelegate).window!.addSubview(object)
        (UIApplication.shared.delegate as! AppDelegate).window!.bringSubviewToFront(object)
        object.alpha = 0
        PromptView.isShow = true
        UIView.animate(withDuration: 0.25) {
            object.alpha = 1
        }
        self.perform(#selector(PromptView.hidden), with: nil, afterDelay: 1.25)
    }
    
    @objc private class func hidden() {
        UIView.animate(withDuration: 0.25, animations: {
            PromptView.shared.alpha = 0
            }, completion: { (flag) in
                if flag {  //取消执行后flag为false
                    PromptView.isShow = false
                    PromptView.shared.removeFromSuperview()
                }
        })
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    private convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private init(a: Int) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// imageV
    fileprivate let imageV: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    /// titleL
    fileprivate let titleL: UILabel = {
        let object = UILabel()
        object.font = UIFont.boldSystemFont(ofSize: 13)
        object.textAlignment = .center
        object.numberOfLines = 0
        object.textColor = UIColor.white
        return object
    }()
    
    /// isShow 是否已经显示
    fileprivate static var isShow = false
}
