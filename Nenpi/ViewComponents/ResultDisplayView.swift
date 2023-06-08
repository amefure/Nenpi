//
//  ResultDisplayView.swift
//  Nenpi
//
//  Created by t&a on 2023/06/08.
//

import SwiftUI

struct ResultDisplayView: View {
    
    let title:String
    let result:String
    let judge:Bool
    let unit:String
    
    var body: some View {
        HStack (alignment: .bottom,spacing: 20){
            Text(title)
            Text(result)
                .font(.title)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .foregroundColor(judge ?  Color.white : Color.orange)
                .frame(width: 150,alignment: .trailing)
            Text(unit)
        }.frame(width: 300, height: 80)
    }
}
