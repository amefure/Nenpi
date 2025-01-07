//
//  NenpiListView.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import SwiftUI

struct ListNenpiView: View {
    
    @EnvironmentObject var rootEnvironment: RootEnvironment
    
    var body: some View {
        NavigationView{
            VStack{
                List(rootEnvironment.allData.reversed()) { item in
                    NavigationLink(destination: {
                        DetailNenpiView(item:item)
                            .environmentObject(rootEnvironment)
                    }, label: {
                        RowNenpiView(item:item)
                    })
                    
                }.listStyle(GroupedListStyle()) // Listのスタイルを横に広げる
                
                RewardButtonView()
                    .environmentObject(rootEnvironment)
            }
        }.navigationViewStyle(.stack)
    }
}

struct NenpiListView_Previews: PreviewProvider {
    static var previews: some View {
        ListNenpiView()
            .environmentObject(RootEnvironment())
    }
}
