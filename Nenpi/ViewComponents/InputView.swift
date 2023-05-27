//
//  InputView.swift
//  Nenpi
//
//  Created by t&a on 2022/09/09.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text:String
    var title:String
    var placeholder:String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        HStack(spacing: 20){
            Text(title)
                .frame(width: 120)
                .foregroundColor(text.isEmpty ?  Color.white : Color.orange)
            TextField(placeholder, text: $text)
                .frame(width: 120)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .multilineTextAlignment(TextAlignment.trailing)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        }.frame(width: 200,alignment: .center)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: Binding.constant(""),title: "",placeholder: "")
    }
}
