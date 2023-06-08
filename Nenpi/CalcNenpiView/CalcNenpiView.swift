//
//  CaclNenpi.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcNenpiView: View {
    
    // MARK: - ViewModels
    private let dataTypeConverter = DataTypeConverter()
    private let deviceSizeVM = DeviceSizeViewModel()
    private let calculationVM = CalculationViewModel()
    
    // MARK: - Environment
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var nenpiData: AllNenpiData
    
    // MARK: - プロパティ
    @State var startMeter:String = ""    // 開始メーター
    @State var endMeter:String = ""      // 終了メーター
    @State var milage:String = ""        // 走行距離
    @State var refueling:String = ""     // 給油量
    @State var cost:String = ""          // コスト
    
    // MARK: - View
    @State var isClick:Bool = false
    @FocusState var isInputActive:Bool  // ナンバーパッドのフォーカス

    
    var body: some View {
        
        VStack {
            
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
                        milage = String(dataTypeConverter.convertStrToInt(endMeter) - dataTypeConverter.convertStrToInt(startMeter))
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
            ResultDisplayView(title: "燃費：",
                              result: "\((String(format: "%.1f", calculationVM.calcNenpi(milage: milage, refueling: refueling))))",
                              judge: (calculationVM.calcNenpi(milage: milage, refueling: refueling) == 0 || cost == ""),
                              unit: "km/ℓ")
          
            
            EntryButtonView(startMeter: $startMeter, endMeter: $endMeter, milage: $milage, refueling: $refueling, cost: $cost)
            
            
            // MARK: - AdMob
            AdMobBannerView()
                .frame(height:50)
            
        }.frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.3, green: 0.3, blue: 0.3))
            .ignoresSafeArea()
       
    }
}


struct CalcNenpiView_Previews: PreviewProvider {
    static var previews: some View {
        CalcNenpiView()
    }
}
