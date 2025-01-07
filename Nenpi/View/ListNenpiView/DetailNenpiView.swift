//
//  EditNenpiView.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import SwiftUI

struct DetailNenpiView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @Environment(\.dismiss) var dismiss
    @State private var isAlertDelete: Bool = false
    
    public var item: NenpiData
    var body: some View {
        
        List{
            Section("登録日") {
                HStack{
                    Spacer()
                    Text("\(item.time)").foregroundColor(.gray)
                }
            }
            Section("燃費"){
                HStack{
                    Spacer()
                    Text("\(String(format: "%.1f", item.nenpi))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("km/ℓ").offset(x: 0, y: 5)
                }
            }
            
            Section("ガソリン料金"){
                HStack{
                    Spacer()
                    Text("\(item.cost)").font(.system(size: 40)).foregroundColor(.orange)
                    Text("円").offset(x: 0, y: 5)
                }
            }
            
            Section("給油量"){
                HStack{
                    Spacer()
                    Text("\(String(format: "%.1f", item.refueling))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("ℓ").offset(x: 0, y: 5)
                }
            }
            
            Section("ガソリン単価"){
                HStack{
                    Spacer()
                    Text("\(String(format: "%.1f", Double(item.cost) / item.refueling))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("円").offset(x: 0, y: 5)
                }
            }
            
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAlertDelete = true
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                })
                .alert(isPresented: $isAlertDelete){
                    Alert(title:Text("燃費情報を削除しますか？"),
                          message: Text(""),
                          primaryButton: .destructive(Text("削除する"),
                                                      action: {
                        withAnimation(.linear(duration: 0.3)){
                            // 選択されたitemを削除
                            rootEnvironment.removeCash(item)
                            dismiss()
                        }
                    }), secondaryButton: .cancel(Text("キャンセル")))
                }
            }
        }
    }
}


struct EditNenpiView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNenpiView(item: NenpiData(milage: 0, refueling: 0, cost: 0, nenpi: 0))
            .environmentObject(RootEnvironment())
    }
}
