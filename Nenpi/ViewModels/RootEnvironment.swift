//
//  RootEnvironment.swift
//  Nenpi
//
//  Created by t&a on 2025/01/07.
//

import SwiftUI

class RootEnvironment: ObservableObject {
    
    // 燃費情報
    @Published var allData: [NenpiData] = []
    // 請求金額の合計
    @Published var bill: Int = 0  // 請求金額の合計
    
    private let repository = JsonFileRepository()
    
    init() {
        // 初期値を入れていないとメソッドは実行できないためプロパティでも初期値有
        setAllData()
    }
    
    public func setAllData() {
        allData = repository.loadJson()
    }
    
    public func saveJson(milage: String, refueling: String, cost: String) {
        let data = NenpiData(
            milage: milage.toDouble(),
            refueling: refueling.toDouble(),
            cost: cost.toInt(),
            nenpi: CalculationUtility.calcNenpi(milage: milage, refueling: refueling)
        )
        repository.saveJson(data)
        setAllData()
    }
    
    public func loadLimitTxt() -> Int {
        repository.loadLimitTxt()
    }
    
    public func addLimitTxt() {
        repository.addLimitTxt()
    }
    
    
    public func removeCash(_ item: NenpiData) {
        guard let index = allData.firstIndex(of:item) else { return }
        allData.remove(at: index)
        repository.updateJson(allData)
        setAllData()
    }
    
    public func updateLocation(_ item:NenpiData,_ id:UUID){
        guard let index = allData.firstIndex(where: { $0.id == id }) else { return }
        self.allData[index] = item
    }
}

