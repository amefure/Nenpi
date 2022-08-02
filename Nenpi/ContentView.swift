//
//  ContentView.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct ContentView: View {
   @State var selectedTag = 1
   @FocusState var isInputActive:Bool  // ナンバーパッドのフォーカス
    
    
    var body: some View {
        
        TabView(selection: $selectedTag){
            CalcNenpiView().tabItem{
                Image(systemName: "fuelpump.circle")
                Text("Nenpi")
                
            }.tag(1)
            .focused($isInputActive)
            CalcPriceView().tabItem{
                Image(systemName: "car.circle")
                Text("Price")
                    
                    
            }.tag(2)
            .focused($isInputActive)
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()  // 右寄せにする
                Button("閉じる") {
                    isInputActive = false
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
