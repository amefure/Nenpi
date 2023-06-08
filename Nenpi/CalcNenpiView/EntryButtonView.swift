//
//  EntryButtonView.swift
//  Nenpi
//
//  Created by t&a on 2023/06/08.
//

import SwiftUI

struct EntryButtonView: View {
    
    private let fileController = FileController()
    private let dataTypeConverter = DataTypeConverter()
    private let calculationVM = CalculationViewModel()
    
    @EnvironmentObject var nenpiData: AllNenpiData
    
    // MARK: - プロパティ
    @Binding var startMeter:String     // 開始メーター
    @Binding var endMeter:String       // 終了メーター
    
    @Binding var milage:String         // 走行距離
    @Binding var refueling:String      // 給油量
    @Binding var cost:String           // コスト
    
    // MARK: - View
    @State var isLimitAlert:Bool = false        // 保存制限ポップアップアラート
    
    
    private func resetInput (){
        milage = ""      // 走行距離
        refueling = ""   // 給油量
        cost = ""        // コスト
        startMeter = ""  // 開始メーター
        endMeter = ""    // 終了メーター
    }
    
    
    var body: some View {
        // MARK: - 登録ボタン
        Button(action: {
            if fileController.loadLimitTxt() <= nenpiData.allData.count{
                isLimitAlert = true
            }else{
                if calculationVM.calcNenpi(milage: milage, refueling: refueling) != 0 && cost != "" {
                    fileController.saveJson(NenpiData(milage: dataTypeConverter.convertStrToDouble(milage), refueling: dataTypeConverter.convertStrToDouble(refueling), cost: Int(dataTypeConverter.convertStrToInt(cost)), nenpi: calculationVM.calcNenpi(milage: milage, refueling: refueling)))
                    nenpiData.setAllData()
                    resetInput()
                }
            }
        }, label: {
            Text("登録")
                .fontWeight(.bold)
                .frame(width: 160,height: 20)
                .padding()
                .background(calculationVM.calcNenpi(milage: milage, refueling: refueling) == 0 ? .gray : .orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            
        }).disabled(calculationVM.calcNenpi(milage: milage, refueling: refueling) == 0)
            .padding(.bottom,30)
            .alert(isPresented: $isLimitAlert){
                Alert(title:Text("上限に達しました"),
                      message: Text("広告を視聴すると\n容量を増やすことができます。"),
                      dismissButton: .default(Text("OK")))
            }
    }
}
