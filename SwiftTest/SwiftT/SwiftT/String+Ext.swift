//
//  String+Ext.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/13.
//  Copyright © 2018年 jzt. All rights reserved.
//

import Foundation
extension String {
    func subStr(start:NSInteger,end:NSInteger) -> String {
        
        if start > end {
            print("起始位置不能大于结束位置")
            return "";
        }
        
        let indexStart = self.index(self.startIndex, offsetBy: start)
        let indexEnd = self.index(self.startIndex, offsetBy: end)
        return String(self[indexStart..<indexEnd]);
    }
    
    
    func subStrTo(end:NSInteger) -> String {
        
        if self.count < end {
            print("越界了")
            return "";
        }
        let indexEnd = self.index(self.startIndex, offsetBy: end)
        return String(self[..<indexEnd]);
    }
    
    func subStrFrom(start:NSInteger) -> String {
        
        if self.count < start {
            print("越界了")
            return "";
        }
        let indexStart = self.index(self.startIndex, offsetBy: start)
        return String(self[indexStart..<self.endIndex]);
    }
    
}
