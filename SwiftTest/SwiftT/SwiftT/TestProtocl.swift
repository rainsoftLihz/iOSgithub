//
//  TestProtocl.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/17.
//  Copyright © 2018年 jzt. All rights reserved.
//

import Foundation

protocol TestProtocl {
    
    var name : String { get set}
    
    func login(name : String , passwd : String) -> Bool
    
}
