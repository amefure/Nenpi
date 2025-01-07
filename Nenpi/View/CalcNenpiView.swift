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
    @State private var isLimitAlert: Bool = false
    @State private var isEntrySuccessAlert: Bool = false
    
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
                    Text(!isClick ? L10n.nenpiCalcMeter : L10n.nenpiCalcDistance)
                }).frame(height:50)
                    .foregroundColor(.orange)
                
                if isClick {
                    VStack{
                        InputView(text: $startMeter, title: L10n.nenpiStartMeter, placeholder: "25000m")
                        InputView(text: $endMeter, title: L10n.nenpiEndMeter, placeholder: "25500m")
                    }.onChange(of:[startMeter,endMeter]){newValue in
                        milage = String(endMeter.toInt() - startMeter.toInt())
                    }
                }else{
                    InputView(text: $milage, title: L10n.nenpiMileage, placeholder: "km")
                }
                InputView(text: $refueling, title: L10n.nenpiRefuelingt, placeholder: "ℓ")
                InputView(text: $cost, title: L10n.nenpiPrice, placeholder: L10n.priceAmountUnitMark)
            }.frame( height: 200)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()  // 右寄せにする
                        Button(L10n.keyboardClose) {
                            isInputActive = false
                        }
                    }
                }
            
            // MARK: - Input
            
            
            // MARK: - Nenpi  
            ResultDisplayView(
                title: L10n.nenpiNenpi + "：",
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
                        isEntrySuccessAlert = true
                    }
                }
            } label: {
                Text(L10n.nenpiEnrty)
                    .fontWeight(.bold)
                    .frame(width: 160, height: 20)
                    .padding()
                    .background(CalculationUtility.calcNenpi(milage: milage, refueling: refueling) == 0 ? .gray : .orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }.disabled(CalculationUtility.calcNenpi(milage: milage, refueling: refueling) == 0)
                .padding(.bottom,30)
                .alert(
                    isPresented: $isLimitAlert,
                    title: L10n.nenpiEnrtyLimitTitle,
                    message: L10n.nenpiEnrtyLimitMsg
                )
                .alert(
                    isPresented: $isEntrySuccessAlert,
                    title: L10n.alertNotify,
                    message: L10n.nenpiEnrtySuccessMsg
                )
            
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
