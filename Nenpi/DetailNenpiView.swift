//
//  EditNenpiView.swift
//  Nenpi
//
//  Created by t&a on 2022/09/08.
//

import SwiftUI

struct DetailNenpiView: View {
    @EnvironmentObject var nenpiData: AllNenpiData
    @Environment(\.dismiss) var dismiss
    
    let fileController = FileController()
    // MARK: - View
    @State var isAlertDelete:Bool = false
    
    var item:NenpiData
    var body: some View {
        VStack(){
            Text("\(item.time)").foregroundColor(.gray)
            Spacer()
            
            VStack{
                Text("燃費").padding(5).background(.orange).cornerRadius(10)
                HStack{
                    Text("\(String(format: "%.1f", item.nenpi))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("km/ℓ").offset(x: 0, y: 5)
                }
            }
            VStack{
                Text("ガソリン料金").padding(5).background(.orange).cornerRadius(10)
                HStack{
                    Text("\(item.cost)").font(.system(size: 40)).foregroundColor(.orange)
                    Text("円").offset(x: 0, y: 5)
                }
            }
            VStack{
                Text("給油量").padding(5).background(.orange).cornerRadius(10)
                HStack{
                    Text("\(String(format: "%.1f", item.refueling))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("ℓ").offset(x: 0, y: 5)
                }
            }
            VStack{
                Text("ガソリン単価").padding(5).background(.orange).cornerRadius(10)
                HStack{
                    Text("\(String(format: "%.1f", Double(item.cost) / item.refueling))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("円").offset(x: 0, y: 5)
                }
            }
        
            Spacer()
            
            
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAlertDelete = true
                }, label: {
                    Image(systemName: "trash").foregroundColor(.red)
                })
                .alert(isPresented: $isAlertDelete){
                    Alert(title:Text("燃費情報を削除しますか？"),
                          message: Text(""),
                          primaryButton: .destructive(Text("削除する"),
                                                      action: {
                        withAnimation(.linear(duration: 0.3)){
                            nenpiData.removeCash(item)   // 選択されたitemを削除
                            fileController.updateJson(nenpiData.allData) // JSONファイルを更新
                            nenpiData.setAllData() // JSONファイルをプロパティにセット
                            
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
    }
}
