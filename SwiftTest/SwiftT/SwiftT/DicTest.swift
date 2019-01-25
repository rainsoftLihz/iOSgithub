//
//  DicTest.swift
//  SwiftT
//
//  Created by rainsoft on 2018/11/26.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class DicTest: NSObject {

   static func testDic(){
    var sumDic = ["A":"AA","B":"BB","C":111] as [String : Any];
        print(sumDic["A"]!);
        
        for (key,value) in sumDic {
            if key == "C" {
                print(sumDic["C"]!);
            }
        
            print("key:\(key) value:\(value)")
        }
    
    
       sumDic["DD"] = "DD";
       sumDic["A"] = "AAAAAA";
        
        //获取所有key
        let dicKeys = sumDic.keys;
        for key in dicKeys {
             print("\(key)")
        }
        //获取所有value
        let dicValues = sumDic.values;
        for value in dicValues {
             print("\(value)")
        }
    
    
    }
    
}
