//
//  XibViewController.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/17.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class XibViewController: UIViewController {
    
    @IBOutlet weak var ttt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Bundle.main.loadNibNamed("XibViewController", owner: self, options: nil);
    }
    
    @IBAction func clickTTT(_ sender: Any) {
        NSLog("click.....");
        let senderBtn : UIButton = sender as! UIButton;
        senderBtn.setTitle("heheh", for: .normal);
    
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
