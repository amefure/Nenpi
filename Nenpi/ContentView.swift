//
//  ContentView.swift
//  Nenpi
//
//  Created by t&a on 2022/07/02.
//

import SwiftUI

struct ContentView: View {
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.gray
    }
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedTag = 1
    @ObservedObject var nenpiData = AllNenpiData()
    
    
    var body: some View {
        
        TabView(selection: $selectedTag){
            
            CalcNenpiView().environmentObject(nenpiData).tabItem{
                Image(systemName: "fuelpump.circle")
                Text("Nenpi")
            }.tag(1)
            
            // MARK: - View
            CalcPriceView().tabItem{
                Image(systemName: "car.circle")
                Text("Price")
            }.tag(2)
            
            // MARK: - View
            ListNenpiView().environmentObject(nenpiData)
                .tabItem{
                    Image(systemName:"list.bullet")
                    Text("List")
                }.tag(3)
            
        }.font(.system(size: 20))
            .accentColor(.orange)
            .environment(\.colorScheme, .dark)
            .foregroundColor(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
