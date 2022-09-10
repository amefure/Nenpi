//
//  NenpiData.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import Foundation

struct NenpiData: Identifiable,Codable,Equatable {

    var id = UUID()             // 一意の値
    var milage:Int              // 走行距離数
    var refueling:Int           // 給油量
    var cost:Int                // 料金
    var nenpi:Int               // 燃費
    var car:String  = "myCar"   // 車の名前
    var time:String = {         // 初期値に現在の日付
        
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateStyle = .short
        df.timeStyle = .none
        
        return df.string(from: Date())

    }()
    
}

// MARK: -

class AllNenpiData:ObservableObject{
    
    // MARK: - プロパティ
    @Published var allData:[NenpiData] = [] // 全情報
    @Published var bill:Int = 0  // 請求金額の合計
    
    init(){
        // 初期値を入れていないとメソッドは実行できないためプロパティでも初期値有
        self.setAllData()
    }
    
    // MARK: - メソッド
    func setAllData(){
        let f = FileController()
        self.allData = f.loadJson()
    }
    
    
    func removeCash(_ item:NenpiData) {
        guard let index = allData.firstIndex(of:item) else { return }
        allData.remove(at: index)
    }
    
    func updateLocation(_ item:NenpiData,_ id:UUID){
        guard let index = allData.firstIndex(where: { $0.id == id }) else { return }
        self.allData[index] = item
    }
}

