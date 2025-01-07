//
//  CaclNenpi.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcNenpiView: View {
    
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    // MARK: - プロパティ
    @State private var startMeter: String = ""    // 開始メーター
    @State private var endMeter: String = ""      // 終了メーター
    @State private var milage: String = ""        // 走行距離
    @State private var refueling: String = ""     // 給油量
    @State private var cost: String = ""          // コスト
    
    @State private var isClick: Bool = false
    @FocusState var isInputActive: Bool  // ナンバーパッドのフォーカス
    
    // 保存制限ポップアップアラート
    @State private var isLimitAlert:Bool = false
    
    private func resetInput () {
        milage = ""      // 走行距離
        refueling = ""   // 給油量
        cost = ""        // コスト
        startMeter = ""  // 開始メーター
        endMeter = ""    // 終了メーター
    }

    
    var body: some View {
        
        VStack {
            
            AdMobBannerView()
                .frame(height: 50)
            
            Spacer()
            
            // MARK: - Icon
            Image(systemName: "fuelpump.circle")
                .ex_ResizableTopIconModifier()
            
            
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
                        milage = String(endMeter.toInt() - startMeter.toInt())
                    }
                }else{
                    InputView(text: $milage, title: "走行距離", placeholder: "km")
                }
                InputView(text: $refueling, title: "給油量", placeholder: "ℓ")
                InputView(text: $cost, title: "料金", placeholder: "¥")
            }.frame( height: 200)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()  // 右寄せにする
                        Button("閉じる") {
                            isInputActive = false
                        }
                    }
                }
            
            // MARK: - Input
            
            
            // MARK: - Nenpi  
            ResultDisplayView(
                title: "燃費：",
                result: "\((String(format: "%.1f", CalculationUtility.calcNenpi(milage: milage, refueling: refueling))))",
                judge: (CalculationUtility.calcNenpi(milage: milage, refueling: refueling) == 0 || cost == ""),
                unit: "km/ℓ"
            )
          
            
            // MARK: - 登録ボタン
            Button {
                if rootEnvironment.loadLimitTxt() <= rootEnvironment.allData.count {
                    isLimitAlert = true
                } else {
                    if CalculationUtility.calcNenpi(milage: milage, refueling: refueling) != 0 && cost != "" {
                        rootEnvironment.saveJson(milage: milage, refueling: refueling, cost: cost)
                        resetInput()
                    }
                }
            } label: {
                Text("登録")
                    .fontWeight(.bold)
                    .frame(width: 160, height: 20)
                    .padding()
                    .background(CalculationUtility.calcNenpi(milage: milage, refueling: refueling) == 0 ? .gray : .orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }.disabled(CalculationUtility.calcNenpi(milage: milage, refueling: refueling) == 0)
                .padding(.bottom,30)
                .alert(isPresented: $isLimitAlert) {
                    Alert(
                        title:Text("上限に達しました"),
                        message: Text("広告を視聴すると\n容量を増やすことができます。"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            
            
            Spacer()
            
           
            
        }.frame(width: DeviceSizeUtility.deviceWidth)
            .background(Color(red: 0.3, green: 0.3, blue: 0.3))
    }
}


struct CalcNenpiView_Previews: PreviewProvider {
    static var previews: some View {
        CalcNenpiView()
            .environmentObject(RootEnvironment())
    }
}
