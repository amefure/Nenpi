//
//  RewardButtonView.swift
//  Nenpi
//
//  Created by t&a on 2022/09/10.
//

import SwiftUI

struct RewardButtonView: View {
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    // MARK: - AdMob reward広告
    @ObservedObject private var reward = Reward()
    // リワード広告視聴回数制限アラート
    @State private var isAlertReward: Bool = false
    @AppStorage("LastAcquisitionDate") var lastAcquisitionDate = ""
    
    var body: some View {
        VStack {
            
            Divider()
            
            Button {
                // 1日1回までしか視聴できないようにする
                if lastAcquisitionDate != reward.nowTime() {
                    reward.showReward()          //  広告配信
                    rootEnvironment.addLimitTxt() // 報酬獲得
                    lastAcquisitionDate = reward.nowTime() // 最終視聴日を格納
                    
                } else {
                    isAlertReward = true
                }
            } label: {
                Image(systemName: "play.circle")
                Text("広告を視聴する")
                    .fontWeight(.bold)
            }.padding()
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            
            
            Text("現在の容量：\(rootEnvironment.loadLimitTxt())個")
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text("・広告を視聴して保存容量を3個追加することが可能です。")
                .font(.caption)
            
        }.background(.clear)
            .onAppear { reward.loadReward() }
            .disabled(!reward.rewardLoaded)
            .alert(isPresented: $isAlertReward){
                Alert(title:Text("お知らせ"),
                      message: Text("広告を視聴できるのは1日に1回までです"),
                      dismissButton: .default(Text("OK"),
                                              action: {}))
            }.padding(.bottom,30)
    }
}
struct RewardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RewardButtonView()
    }
}
