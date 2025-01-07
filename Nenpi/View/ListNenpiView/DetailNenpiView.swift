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
            Section(L10n.detailEntryDay) {
                HStack{
                    Spacer()
                    Text("\(item.time)").foregroundColor(.gray)
                }
            }
            Section(L10n.nenpiNenpi) {
                HStack{
                    Spacer()
                    Text("\(String(format: "%.1f", item.nenpi))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("km/ℓ").offset(x: 0, y: 5)
                }
            }
            
            Section(L10n.detailGasoline + L10n.nenpiPrice) {
                HStack{
                    Spacer()
                    Text("\(item.cost)").font(.system(size: 40)).foregroundColor(.orange)
                    Text(L10n.priceAmountUnit).offset(x: 0, y: 5)
                }
            }
            
            Section(L10n.nenpiRefuelingt) {
                HStack{
                    Spacer()
                    Text("\(String(format: "%.1f", item.refueling))").font(.system(size: 40)).foregroundColor(.orange)
                    Text("ℓ").offset(x: 0, y: 5)
                }
            }
            
            Section(L10n.detailGasoline + L10n.priceUnit) {
                HStack{
                    Spacer()
                    Text("\(String(format: "%.1f", Double(item.cost) / item.refueling))").font(.system(size: 40)).foregroundColor(.orange)
                    Text(L10n.priceAmountUnit).offset(x: 0, y: 5)
                }
            }
            
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAlertDelete = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }.alert(
                    isPresented: $isAlertDelete,
                    title: L10n.detailDeleteAlertTitle,
                    message: "",
                    positiveButtonTitle: L10n.alertDelete,
                    negativeButtonTitle: L10n.alertCancel,
                    positiveButtonRole: .destructive,
                    positiveAction: {
                        withAnimation(.linear(duration: 0.3)){
                            // 選択されたitemを削除
                            rootEnvironment.removeCash(item)
                            dismiss()
                        }
                    }
                )
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
