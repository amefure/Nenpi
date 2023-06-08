//
//  CalculationViewModel.swift
//  Nenpi
//
//  Created by t&a on 2023/06/08.
//

import UIKit

class CalculationViewModel {
    
    private let dataTypeConverter = DataTypeConverter()
    
    public func calcNenpi (milage:String,refueling:String) -> Double{
        if milage == "" ||  refueling == ""{
            return 0
        }
        
        let milageNum = dataTypeConverter.convertStrToInt(milage)
        let refuelingNum = dataTypeConverter.convertStrToInt(refueling)
        let result = Double(milageNum / refuelingNum)
        return ceil(result * 100)/100
    }
    
    public func calcPrice (distance:String,nenpi:String,cost:String) -> Int{
        if distance == "" ||  nenpi == "" ||  cost == ""{
            return 0
        }
        
        let distanceNum = dataTypeConverter.convertStrToDouble(distance)
        let nenpiNum = dataTypeConverter.convertStrToInt(nenpi)
        let costNum = dataTypeConverter.convertStrToInt(cost)
        let result = round(distanceNum / Double(nenpiNum) * Double(costNum))
        return Int(result)
    }
}
