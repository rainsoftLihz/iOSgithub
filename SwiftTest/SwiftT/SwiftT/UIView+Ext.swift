//
//  UIView+Ext.swift
//  SwiftT
//
//  Created by rainsoft on 2018/12/18.
//  Copyright © 2018年 jzt. All rights reserved.
//

import Foundation
extension UIView{
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

