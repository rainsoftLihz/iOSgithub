//
//  MansoryViewController.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/18.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit
import SnapKit
class MansoryViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red;
        // Do any additional setup after loading the view.
        let box = UIView();
        self.view.addSubview(box);
        box.layer.borderWidth = 1.0;
        box.layer.borderColor = UIColor.white.cgColor;
        box.snp.makeConstraints { (make) in
            make.left.top.equalTo(100);
            make.height.width.equalTo(100);
        }
        
        
        let box1 = UILabel();
        self.view.addSubview(box1);
        box1.text = "ABCDASDSDJFEJWEFJWEJFWJE";
        box1.font = UIFont.systemFont(ofSize: 18.0);
        box1.snp.makeConstraints { (make) in
            make.top.equalTo(box.snp.bottom).offset(10);
            make.left.equalTo(box.snp.left);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
