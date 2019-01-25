//
//  StringTest.swift
//  SwiftT
//
//  Created by rainsoft on 2018/11/26.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class StringTest: NSObject {
    
    var name : String?
    
    override init() {
        super.init();
        name = "JACK";
    }

    func show(str:String) -> Void {
        //大小写
        print(str.lowercased());
        print(str.uppercased());
        
        print(String(format: "my name is %@", name!));
        
        print(self.subStr(index: 2))  ;
        
    }
    
    public func subStr(index:NSInteger) {
        let helloWorld : String = "Hello, World!"

        print(helloWorld.subStrFrom(start: 3));
        let str:String = "ABCDEFGHIGHERER";

        print(str.subStr(start: 3, end: 6));
    }
}
