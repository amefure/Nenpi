//
//  CalcPriceView.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcPriceView: View {
    
    // MARK: - ViewModels
    private let dataTypeConverter = DataTypeConverter()
    private let deviceSizeVM = DeviceSizeViewModel()
    private let calculationVM = CalculationViewModel()
    
    // MARK: - プロパティ
    @State var distance:String = ""     // 距離
    @State var nenpi:String = ""        // 燃費
    @State var cost:String = ""         // ガソリン単価

    // MARK: - View
    @FocusState var isInputActive:Bool  // ナンバーパッドのフォーカス

    
    var body: some View {
        
        VStack {
            
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
            ResultDisplayView(title: "料金：",
                              result: "\(calculationVM.calcPrice(distance: distance, nenpi: nenpi, cost: cost))",
                              judge: (calculationVM.calcPrice(distance: distance, nenpi: nenpi, cost: cost) == 0),
                              unit: "円")

            
            
            AdMobBannerView().frame(height:50).padding(.top,90)
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.5, green: 0.6, blue: 0.5))
        .ignoresSafeArea()
    }
}

struct CalcPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CalcPriceView()
        //            .previewInterfaceOrientation(.landscapeRight)
    }
}
