//
//  CaclNenpi.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcNenpiView: View {
    // MARK: - プロパティ
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var fileController = FileController()
    @EnvironmentObject var nenpiData: AllNenpiData
    
    // MARK: - プロパティ
    @State var startMeter:String = ""    // 開始メーター
    @State var endMeter:String = ""      // 終了メーター
    
    @State var milage:String = ""    // 走行距離
    @State var refueling:String = "" // 給油量
    @State var cost:String = ""      // コスト
    
    // MARK: - View
    @State var isClick:Bool = false
    @State var isLimitAlert:Bool = false        // 保存制限ポップアップアラート
    // MARK: - プロパティ
    func calcNenpi (milage:String,refueling:String) -> Double{
        if milage == "" ||  refueling == ""{
            return 0
        }
        
        let milageNum = changeNum(milage)
        let refuelingNum = changeNum(refueling)
        let result = Double(milageNum / refuelingNum)
//        let result = round(Double(milageNum / refuelingNum))
        return ceil(result * 100)/100
//        return Double(result)
    }
    
    
    func changeNum (_ str:String) -> Double{
        guard let num = Double(str) else {
            // 文字列の場合
            return 1
        }
        return num
    }
    
    func resetInput (){
        milage = ""      // 走行距離
        refueling = ""   // 給油量
        cost = ""        // コスト
        startMeter = ""  // 開始メーター
        endMeter = ""    // 終了メーター
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Icon
            Image(systemName: "fuelpump.circle")
                .resizable(resizingMode: .stretch)
                .frame(width: UIScreen.main.bounds.height < 750 ? 100.0 : 150.0, height: UIScreen.main.bounds.height < 750 ? 100.0 : 150.0)
                .padding(.bottom,(UIScreen.main.bounds.height < 750 ? 30 : 145.0))
                .foregroundColor((calcNenpi(milage: milage, refueling: refueling) == 0 || cost == "") ?  Color.white : Color.orange)
            
            // MARK: - Input
            VStack{
                Button(action: {
                    isClick.toggle()
                }, label: {
                    Text(!isClick ? "メーターで計算する" : "距離数で入力する")
                }).frame(height:50)
                    .foregroundColor(.orange)
                
                if isClick {
                    VStack{
                        InputView(text: $startMeter, title: "開始メーター", placeholder: "25000m")
                        InputView(text: $endMeter, title: "終了メーター", placeholder: "25500m")
                    }.onChange(of:[startMeter,endMeter]){newValue in
                        milage = String(changeNum(endMeter) - changeNum(startMeter))
                    }
                }else{
                    InputView(text: $milage, title: "走行距離", placeholder: "km")
                }
            InputView(text: $refueling, title: "給油量", placeholder: "ℓ")
            InputView(text: $cost, title: "料金", placeholder: "¥")
            }.frame( height: 200)
            
            // MARK: - Input
            
            // MARK: - Nenpi
            HStack (alignment: .bottom,spacing: 20){
                Text("燃費：")
                Text("\((String(format: "%.1f", calcNenpi(milage: milage, refueling: refueling))))")
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .foregroundColor((calcNenpi(milage: milage, refueling: refueling) == 0 || cost == "") ?  Color.white : Color.orange)
                    .frame(width: 150,alignment: .trailing)
                Text("km/ℓ")
            }.frame(width: 300, height: 80)
            
            // MARK: - 登録ボタン
            Button(action: {
                
                if fileController.loadLimitTxt() <= nenpiData.allData.count{
                    isLimitAlert = true
                }else{
                    if calcNenpi(milage: milage, refueling: refueling) != 0 && cost != "" {
                        fileController.saveJson(NenpiData(milage: changeNum(milage), refueling: changeNum(refueling), cost: Int(changeNum(cost)), nenpi: calcNenpi(milage: milage, refueling: refueling)))
                        nenpiData.setAllData()
                        resetInput()
                    }
                }
                
                
            }, label: {
                Text("登録")
                    .frame(width: 200,height: 20)
                    .padding()
                    .background(calcNenpi(milage: milage, refueling: refueling) == 0 ? .gray : .orange)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }).disabled(calcNenpi(milage: milage, refueling: refueling) == 0)
                .padding(.bottom,30)
                .alert(isPresented: $isLimitAlert){
                    Alert(title:Text("上限に達しました"),
                          message: Text("広告を視聴すると\n容量を増やすことができます。"),
                          dismissButton: .default(Text("OK")))
                }
                
            // MARK: - 登録ボタン
                    
            AdMobBannerView().frame(width:UIScreen.main.bounds.width,height:50)
            
        }.padding()
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.3, green: 0.3, blue: 0.3))
            .foregroundColor(Color.white)
            .ignoresSafeArea()
        
        
        
    }
}


struct CalcNenpiView_Previews: PreviewProvider {
    static var previews: some View {
        CalcNenpiView()
    }
}
