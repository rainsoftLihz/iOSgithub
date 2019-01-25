//
//  PanView.swift
//  SwiftT
//
//  Created by rainsoft on 2018/11/28.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class PanView: UIView {

    
    override func draw(_ rect: CGRect) {
         //Drawing code
    }
 
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取手指
        let touch = (touches as NSSet).anyObject() as! UITouch
        let nowLocation = touch.location(in: self)
        let preLocation = touch.previousLocation(in: self)
        
        //获取两个手指的偏移量
        let offsetX = nowLocation.x - preLocation.x
        let offsetY = nowLocation.y - preLocation.y
        
        var center = self.center
        center.x += offsetX
        center.y += offsetY
        
        let size:CGSize = self.frame.size;
        let screenBounds:CGRect = UIScreen.main.bounds;
        if (center.x - size.width/2.0) < 0 {
            center.x = size.width/2.0;
        }
        
        if (center.x + size.width/2.0) > screenBounds.size.width {
            center.x = screenBounds.size.width - size.width/2.0;
        }
        
        if (center.y - size.height/2.0) < 20 {
            center.y = size.height/2.0+20;
        }
        
        if (center.y + size.height/2.0) > (screenBounds.size.height - 40) {
            center.y = screenBounds.size.height - size.height/2.0 - 40;
        }
        
        
        
        self.center = center
    }

}
