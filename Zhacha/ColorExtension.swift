//
//  ColorExtension.swift
//  Zhacha
//
//  Created by ZZ on 2019/9/2.
//  Copyright © 2019 ZZ. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 设置随机颜色
    class var extRandom: UIColor {
        get {
            return UIColor.init(red: (((CGFloat)((arc4random_uniform(256) % 256)) / 255.0)),
                                green: (((CGFloat)((arc4random_uniform(256) % 256)) / 255.0)),
                                blue: (((CGFloat)((arc4random_uniform(256) % 256)) / 255.0)),
                                alpha: 1.0);
        }
    }
 
    /// 设置颜色（RGB：0.0~255.0） 示例：UIColorRGB(100, 100, 100)
    class func extRGB(_ R: CGFloat, G: CGFloat, B: CGFloat) -> UIColor {
        return extAlpha(R, G: G, B: B, alpha: 1.0);
    }
    
    /// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
    class func extAlpha(_ R: CGFloat, G: CGFloat, B: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
    }
    
    /// 设置颜色 示例：UIColorHex(0x26A7E8)
    class func extHex(_ value: UInt32) -> UIColor {
        return extHexAlpha(value, alpha: 1.0);
    }
    
    /// 设置颜色与透明度 示例：extHexAlpha(0x26A7E8, 0.5)
    class func extHexAlpha(_ value: UInt32, alpha: CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((value & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((value & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(value & 0xFF)) / 255.0, alpha: 1.0)
    }
    
    /**
     *  设置16进制颜色:
     *  可识别类型
     *  1:有#
     *  2:没有#
     *  3:含有0X
     */
    class func hexadecimalColor(hexadecimal: String) -> UIColor {
        var cstr = hexadecimal.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        
        if(cstr.uppercased.hasPrefix("0X")) {
            cstr = cstr.substring(from: 2) as NSString
        } else if(cstr.hasPrefix("#")) {
            cstr = cstr.substring(from: 1) as NSString
        }
        
        if(cstr.length != 6) {
            return UIColor.clear;
        }
        
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
    }

}


