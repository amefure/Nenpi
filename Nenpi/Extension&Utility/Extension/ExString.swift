//
//  ExString.swift
//  Nenpi
//
//  Created by t&a on 2023/06/07.
//

import UIKit

extension String {
    public func toInt() -> Int {
        guard let num = Int(self) else { return 1 }
        return num
    }
    
    public func toDouble() -> Double {
        guard let num = Double(self) else { return 1 }
        return num
    }
    
    // 数値かチェック
    public func toIntCheck() -> Bool {
        guard Int(self) != nil else { return false }
        return true // 数値の場合
    }
}
