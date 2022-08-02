//
//  CaclNenpi.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct CalcNenpiView: View {
    @State var milage:String = ""   // 走行距離
    @State var refueling:String = ""// 給油量
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    func calcNenpi (milage:String,refueling:String) -> Int{
        if milage == "" ||  refueling == ""{
            return 0
        }
        
        let milageNum = changeNum(milage)
        let refuelingNum = changeNum(refueling)
        let result = round(Double(milageNum / refuelingNum))
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
            
            Image(systemName: "fuelpump.circle")
                .resizable(resizingMode: .stretch)
            .frame(width: 150.0, height: 150.0)
            .padding(.bottom,145.0)
            .foregroundColor((calcNenpi(milage: milage, refueling: refueling) == 0) ?  Color.white : Color.orange)
            
            HStack(spacing: 20){
                Text("走行距離")
                    .frame(width: 100)
                    .foregroundColor(milage.isEmpty ?  Color.white : Color.orange)
                TextField("km", text: $milage)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }.frame(width: 200,alignment: .trailing)


            HStack ( spacing: 20){
                Text("給油量")
                    .frame(width: 100)
                    .foregroundColor(refueling.isEmpty ?  Color.white : Color.orange)
                TextField("ℓ",text: $refueling)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(TextAlignment.trailing)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    
            }.frame(width: 200,alignment: .trailing)


            HStack (alignment: .bottom,spacing: 20){
                Text("燃費：")
                Text("\(calcNenpi(milage: milage, refueling: refueling))")
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .foregroundColor((calcNenpi(milage: milage, refueling: refueling) == 0) ?  Color.white : Color.orange)
                    .frame(width: 150,alignment: .trailing)
                    Text("km/ℓ")
            }.frame(width: 300, height: 80)

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
