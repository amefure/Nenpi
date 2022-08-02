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
        
        let distanceNum = changeNum(distance)
        let nenpiNum = changeNum(nenpi)
        let costNum = changeNum(cost)
        let result = round(Double(distanceNum / nenpiNum * costNum))
        return Int(result)
    }
    
    func changeNum (_ str:String) -> Int{
        guard let num = Int(str) else {
            // 文字列の場合
            return 0
        }
        return num
    }
    
    var body: some View {
        
        VStack {
            Image(systemName: "car.circle")
                .resizable(resizingMode: .stretch)
            .frame(width: 150.0, height: 150.0)
            .padding(.bottom,100.0)
            .foregroundColor((calcPrice(distance: distance, nenpi: nenpi, cost: cost) == 0) ?  Color.white : Color.orange)
            
            
            HStack(spacing: 20){
                Text("走行距離")
                    .frame(width: 100)
                TextField("km", text: $distance)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)

                    
                    
            }.frame(width: 200,alignment: .trailing)
             
            
                
            
            HStack(spacing: 20){
                Text("燃費")
                    .frame(width: 100)
                TextField("km/ℓ", text: $nenpi)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                   
                  
    
                
            }.frame(width: 200,alignment: .trailing)
                
            HStack(spacing: 20){
                Text("単価")
                    .frame(width: 100)
                TextField("¥", text: $cost)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    
                   
                
            }.frame(width: 200,alignment: .trailing)
            
            
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
