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
        
        let distanceNum = changeDouble(distance)
        let nenpiNum = changeNum(nenpi)
        let costNum = changeNum(cost)
        let result = round(distanceNum / Double(nenpiNum) * Double(costNum))
        return Int(result)
    }
    
    func changeNum (_ str:String) -> Int{
        guard let num = Int(str) else {
            // 文字列の場合
            return 1
        }
        return num
    }
    
    func changeDouble (_ str:String) -> Double{
        guard let num = Double(str) else {
            // 文字列の場合
            return 1
        }
        return num
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Icon
            Image(systemName: "car.circle")
            .resizable(resizingMode: .stretch)
            .frame(width: UIScreen.main.bounds.height < 750 ? 100.0 : 150.0, height: UIScreen.main.bounds.height < 750 ? 100.0 : 150.0)
            .padding(.bottom,(UIScreen.main.bounds.height < 750 ? 30 : 145.0))
            .foregroundColor((calcPrice(distance: distance, nenpi: nenpi, cost: cost) == 0) ?  Color.white : Color.orange)
            
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
            
            
            AdMobBannerView().frame(width:UIScreen.main.bounds.width,height:50).padding(.top,90)
        }

        .padding()
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.5, green: 0.6, blue: 0.5))
        .foregroundColor(Color.white)
        .ignoresSafeArea()
        
            
        
    }
}

struct CalcPriceView_Previews: PreviewProvider {
    static var previews: some View {
        CalcPriceView()
//            .previewInterfaceOrientation(.landscapeRight)
    }
}
