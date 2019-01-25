//
//  TextTest.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/13.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class TextTest: UIView,UITextFieldDelegate {

    var textF:UITextField?
    override init(frame: CGRect) {
        super.init(frame:frame);
        self.setSubView();
    }
    
    
    func setSubView() {
        textF = UITextField(frame: self.bounds);
        textF?.borderStyle = .roundedRect;
        textF?.backgroundColor = UIColor.red;
        textF?.textColor = UIColor.white;
        textF?.font = UIFont.systemFont(ofSize: 14.0);
        textF?.placeholder = "请输入...";
        textF?.delegate = self;
        self.addSubview(textF!);
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: NSNotification.Name.UITextFieldTextDidChange, object: nil);
        
    }
    
    
    @objc func textFiledEditChanged(notify:Notification) {
        print("====>>");
        let textf : UITextField = notify.object as! UITextField;
        
        if (textf.text?.count)! > 6 {
            textF?.text = textf.text?.subStrTo(end: 6);
        }
        print("\(textf.text ?? "")");
        print("\(textF?.text ?? "")");
    }
    
    //开始编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin input....");
    }
    
    //点击键盘return响应函数
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "");
        return true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }}
