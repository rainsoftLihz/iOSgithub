//
//  ImageViewController.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/18.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var img1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func click(_ sender: UISegmentedControl) {
        let image = UIApplication.shared.keyWindow!.asImage()
        if sender.selectedSegmentIndex == 0 {
            //左边
            self.img1.image = image;
        }else {
            self.img2.image = image;
        }
        
        //将转换后的UIImage保存到相机胶卷中
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
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
