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
                Text(L10n.rewordWatchAnAd)
                    .fontWeight(.bold)
            }.padding()
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            
            
            Text(L10n.rewordCapacity(rootEnvironment.loadLimitTxt()))
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text(L10n.rewordAddCapacity)
                .font(.caption)
            
        }.background(.clear)
            .onAppear { reward.loadReward() }
            .disabled(!reward.rewardLoaded)
            .alert(
                isPresented: $isAlertReward,
                title: L10n.alertNotify,
                message: L10n.rewordAlertMsg
            ).padding(.bottom,30)
    }
}
struct RewardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RewardButtonView()
    }
}
