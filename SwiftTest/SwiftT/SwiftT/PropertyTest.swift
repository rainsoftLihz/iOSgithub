//
//  PropertyTest.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/10.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class PropertyTest: NSObject {
    
    @objc dynamic var name: String = "";
    
    init(name : String) {
        self.name = name;
        super.init();
    }

   //属性观察器
    var couter : Int = 0 {
        willSet(newCouter){
            print("will set : \(newCouter)")
        }
        
        didSet(oldNumber){
            print("Just changed from \(oldNumber) to \(self.couter)")
        }
    }
    
    override func willChangeValue(forKey key: String) {
        print("====:\(key)");
    }
    
}
