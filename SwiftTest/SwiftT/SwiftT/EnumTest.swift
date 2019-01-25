//
//  EnumTest.swift
//  SwiftT
//
//  Created by rainsoft on 2018/11/26.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

enum Month: Int {
    case January = 1, February, March, April, May, June, July, August, September, October, November, December
}
// 定义枚举
enum DaysofaWeek:Int {
    case Sunday = 7
    case Monday = 1
    case TUESDAY = 3
    case WEDNESDAY = 4
    case THURSDAY = 2
    case FRIDAY = 5
    case Saturday = 6
    
    func description() -> String {
        switch self {
        case .Sunday:
            return "Sunday";
        case.Monday:
            return "Monday";
        case.TUESDAY:
            return "TUESDAY";
        default:
            return "null";
        }
    }
}

enum Barcode {
    case UPCA(size1:Int, size2:Int, size3:Int)
    case QRCode(String)
    
    func checkValue() -> Bool {
        switch (self) {
        case .UPCA(let size1,let size2,let size3):
            if size3+size2+size1 > 50 {
                return true;
            }
            return false;
        default:
            return false;
        }
    }
}

class EnumTest: NSObject {

    static func show() -> Void {
        let yearMonth = Month.February.rawValue;
        print("数字月份为: \(yearMonth)")
        let monthValue = Month.February;
        print("数字月份hash为: \(monthValue)")
        
        let barCode1 = Barcode.UPCA(size1: 12, size2: 23, size3: 34);
        let barCode2 = Barcode.QRCode("ABCDSEEGEGE");
       
        showBar(bar:barCode1);
        showBar(bar:barCode2);
    
    }
    
    static func showBar(bar:Barcode) -> Void {
        switch bar {
        case Barcode.UPCA(let size1 ,let size2 , let size3):
            print(size1+size2+size3);
            print(bar.checkValue());
        case Barcode.QRCode(let valus):
            print(valus)
        }
    }
    
    static func showDay(day : Int) -> Void {
       
        switch day {
        case DaysofaWeek.FRIDAY.rawValue:
            print(DaysofaWeek.FRIDAY);
            print(DaysofaWeek.FRIDAY.description());
            
        case DaysofaWeek.Sunday.rawValue:
            print(DaysofaWeek.Sunday);
        case DaysofaWeek.Monday.rawValue:
            print(DaysofaWeek.Monday);
            print(DaysofaWeek.Monday.description());
            if "\(DaysofaWeek.Monday)" == "Monday" {
                print(" ==== ");
            }
            
            if "\(DaysofaWeek.Monday)" == DaysofaWeek.Monday.description(){
                print(" =+=+ ");
            }
        default:
            print("defalut show");
        }
    }
}
