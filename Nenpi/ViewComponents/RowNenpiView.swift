//
//  RowNenpiView.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import SwiftUI

struct RowNenpiView: View {
    var item:NenpiData
    
    var body: some View {
        HStack {
            VStack {
                // 位置調整
                Text("Nenpi").font(.caption).foregroundColor(.gray).offset(x: 52, y: -16)
                Text("\(item.time)").font(.caption).foregroundColor(.gray).offset(x: -10, y: -10)
            }
        
            // 縦の線を表示
            Rectangle()
            .foregroundColor(.gray)
            .frame(width: 0.2 ,height: 30)
            
            // メモ
            HStack{
                Text("\(String(format: "%.1f", item.nenpi))").lineLimit(1).foregroundColor(.orange).font(.system(size: 30))
                Text("km/ℓ").offset(x: 0, y: 5)
                Spacer()
                Text("\(item.cost)").lineLimit(1).foregroundColor(.orange).font(.system(size: 30))
                Text("円").offset(x: 0, y: 5)
            }
            
            Spacer()
            
            
        }.padding([.top,.trailing])
    }
}

struct RowNenpiView_Previews: PreviewProvider {
    static var previews: some View {
        RowNenpiView(item: NenpiData(milage: 0, refueling: 0, cost: 0, nenpi: 0))
    }
}
