//
//  CalculationUtility.swift
//  Nenpi
//
//  Created by t&a on 2023/06/08.
//

import UIKit

class CalculationUtility {
    
    static func calcNenpi(milage: String, refueling: String) -> Double {
        if milage == "" || refueling == "" { return 0 }
        
        let milageNum = milage.toInt()
        let refuelingNum = refueling.toInt()
        let result = Double(milageNum / refuelingNum)
        return ceil(result * 100)/100
    }
    
    static func calcPrice(distance: String, nenpi: String, cost: String) -> Int {
        if distance == "" || nenpi == "" || cost == "" { return 0 }
        
        let distanceNum = distance.toDouble()
        let nenpiNum = nenpi.toInt()
        let costNum = cost.toInt()
        let result = round(distanceNum / Double(nenpiNum) * Double(costNum))
        return Int(result)
    }
}
