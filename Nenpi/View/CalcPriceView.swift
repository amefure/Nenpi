//
//  CalcPriceView.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcPriceView: View {
    
    
    // MARK: - プロパティ
    @State var distance:String = ""     // 距離
    @State var nenpi:String = ""        // 燃費
    @State var cost:String = ""         // ガソリン単価

    // MARK: - View
    @FocusState var isInputActive:Bool  // ナンバーパッドのフォーカス

    
    var body: some View {
        
        VStack {
            
            AdMobBannerView()
                .frame(height: 50)
            
            Spacer()
            
            // MARK: - Icon
            Image(systemName: "car.circle")
                .ex_ResizableTopIconModifier()
            
            VStack{
                InputView(text: $distance, title: "走行距離", placeholder: "km").padding(.top,60)
                InputView(text: $nenpi, title: "燃費", placeholder: "km/ℓ")
                InputView(text: $cost, title: "単価", placeholder: "¥")
            }.frame(height: 200)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()  // 右寄せにする
                        Button("閉じる") {
                            isInputActive = false
                        }
                    }
                }
            
            // MARK: - Price
            ResultDisplayView(
                title: "料金：",
                result: "\(CalculationUtility.calcPrice(distance: distance, nenpi: nenpi, cost: cost))",
                judge: (CalculationUtility.calcPrice(distance: distance, nenpi: nenpi, cost: cost) == 0),
                unit: "円"
            )

            Spacer()
           
        }.frame(width: DeviceSizeUtility.deviceWidth)
            .background(Color(red: 0.5, green: 0.6, blue: 0.5))
    }
}

struct CalcPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CalcPriceView()
    }
}
