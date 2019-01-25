//
//  ViewController.swift
//  SwiftT
//
//  Created by rainsoft on 2018/11/22.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

private var myContext = 0;

class ViewController: UIViewController,UIGestureRecognizerDelegate,TestProtocl {
    
    var name: String = "";
    
    func login(name: String, passwd: String) -> Bool {
        return true;
    }
    
    
    private let panview : PanView = {
        let pan = PanView.init(frame: CGRect(x: 100, y: 300, width: 100, height: 30));
        pan.backgroundColor = UIColor.red;
        return pan;
    }();
    
    
   private let panlab : UILabel = {
        let lable = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        lable.backgroundColor = UIColor.red;
        lable.text = "拖拽Lable";
        lable.textColor = UIColor.white;
        return lable;
    }();

    private let button : UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100));
        btn.backgroundColor = UIColor.blue;
        btn.setTitle("这是一个按钮", for: .normal);
        btn.setTitle("高粱状态", for: UIControlState.highlighted)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside);
        return btn;
    }();
    
    @objc func btnClick(btn:UIButton) {
        btn.setTitle("ddddd", for: UIControlState.normal);
        panlab.text = "gogogo";
        panlab.backgroundColor = UIColor.black;
        property.name = "Jocgi";
        print(property.name);
    }
    
    //属性观察器
    let property : PropertyTest = PropertyTest.init(name: "jack");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //字典
        //DicTest.testDic();
       
        //枚举
        //EnumTest.show();
        //EnumTest.showDay(day: 1);
        
        self.login(name: self.name, passwd: self.name);
        
        //字符串
        let str = StringTest.init();
        str.name = "ABC";
        str.show(str: "ADsdjojfsdBWEWEFWEFw");
        str.subStr(index: 2);
        
        let textF : TextTest = TextTest.init(frame: CGRect(x: 10, y: 300, width: 100, height: 33));
        self.view.addSubview(textF);
        
        
    
        property.couter = 10;
        //KVO
        property.addObserver(self, forKeyPath:"name", options: [.new,.old], context: &myContext);
        print(property.couter);
        property.couter = 20;
        print(property.name);
        
        
        let tlab : UILabel = {
            let lable = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
            lable.backgroundColor = UIColor.red;
            lable.text = "这是一个Lable";
            lable.textColor = UIColor.white;
            return lable;
        }();
  
        self.view.addSubview(tlab);
        self.view.addSubview(button);
        panlab.addObserver(self, forKeyPath: "text", options: [.new,.old], context: &myContext);
        
        //点击手势
        let gesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labCick(tap: )));
        tlab.addGestureRecognizer(gesture);
        gesture.delegate = self;
        tlab.isUserInteractionEnabled = true;
        
        //拖拽手势
        let pan : UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(pan:)));
        panlab.addGestureRecognizer(pan);
        panlab.isUserInteractionEnabled = true;
        self.view.addSubview(panview);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext {
            guard let key = keyPath,
                let change = change,
                let newVale = change[.newKey] as? String,
                let oldVale = change[.oldKey] as? String
                else {return;}
            
            if key == "name" || key == "text" {
                print("newValue: \(newVale), oldValue: \(oldVale)")
            }else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }

            
        }
    }
    
    @objc func panAction(pan:UIPanGestureRecognizer) {
        let orgin:CGPoint = pan.translation(in: self.view.window)
        //panlab.center = orgin;
        print("orgin:\(orgin)")
    }
    
    @objc func labCick(tap:UITapGestureRecognizer){
        button.setTitle("clickB", for: .normal);
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("begin");
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let VC:TableTestViewController = TableTestViewController();
        
        
        let VV : OCViewController = OCViewController();
        
        
        let  xib:XibViewController = XibViewController();
        
        let img:ImageViewController = ImageViewController();
        
        let mas:MansoryViewController = MansoryViewController();
        self.present(VC, animated: false) {
            print("present")
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

