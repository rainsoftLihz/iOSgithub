//
//  DelegateViewController.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/17.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

protocol choseBackDelegate {
    func choseBack(name : String , passwd : String)
}

class DelegateViewController: UIViewController {
    
    var delegate : choseBackDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red;
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.choseBack(name: "AAA", passwd: "123456");
        self.dismiss(animated: true, completion: nil);
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
