//
//  NenpiData.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import Foundation

struct NenpiData: Identifiable,Codable,Equatable {

    var id = UUID()              // 一意の値
    var milage: Double           // 走行距離数
    var refueling: Double        // 給油量
    var cost :Int                // 料金
    var nenpi: Double            // 燃費
    var car: String  = "myCar"   // 車の名前
    var time: String = {         // 初期値に現在の日付
        
        let df = DateFormatter()
        df.calendar = Calendar.current
        df.locale = Locale.current
        df.timeZone = TimeZone.current
        df.dateStyle = .short
        df.timeStyle = .none
        
        return df.string(from: Date())

    }()
    
}

