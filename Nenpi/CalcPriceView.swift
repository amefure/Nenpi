//
//  CalcPriceView.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcPriceView: View {
    @State var distance:String = ""     // 距離
    @State var nenpi:String = ""        // 燃費
    @State var cost:String = ""         // ガソリン単価
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    func calcPrice (distance:String,nenpi:String,cost:String) -> Int{
        if distance == "" ||  nenpi == "" ||  cost == ""{
            return 0
        }
        
        let distanceNum = dataTypeConverter.convertStrToDouble(distance)
        let nenpiNum = dataTypeConverter.convertStrToInt(nenpi)
        let costNum = dataTypeConverter.convertStrToInt(cost)
        let result = round(distanceNum / Double(nenpiNum) * Double(costNum))
        return Int(result)
    }
    
    private let dataTypeConverter = DataTypeConverter()
    private let deviceSizeVM = DeviceSizeViewModel()
    
    
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
            
            
            HStack (alignment: .bottom,spacing: 20){
                Text("料金：")
                Text("\(calcPrice(distance: distance, nenpi: nenpi, cost: cost))")
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .foregroundColor((calcPrice(distance: distance, nenpi: nenpi, cost: cost) == 0) ?  Color.white : Color.orange)
                    .frame(width: 150,alignment: .trailing)
                Text("円")
            }.frame(width: 300, height: 80)
            
            
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
