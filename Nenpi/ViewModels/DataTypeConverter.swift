//
//  DataTypeConverter.swift
//  Nenpi
//
//  Created by t&a on 2023/06/07.
//

import UIKit

class DataTypeConverter {
    
    public func convertStrToInt (_ str:String) -> Int{
        guard let num = Int(str) else {
            // 文字列の場合
            return 1
        }
        return num
    }
    
    public func convertStrToDouble (_ str:String) -> Double{
        guard let num = Double(str) else {
            // 文字列の場合
            return 1
        }
        return num
    }
}
