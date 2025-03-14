//
//  TotalActivityView.swift
//  ScreenTimeReport
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import SwiftUI
import FamilyControls

/*struct TotalActivityView: View {
    let totalActivity: String
    
    var body: some View {
        Text(totalActivity)
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
#Preview {
    TotalActivityView(totalActivity: "1h 23m")
}
*/


// MARK: - MonitoringView에서 보여줄 SwiftUI 뷰
struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    var body: some View {
        VStack(spacing: 4) {
            Spacer(minLength: 24)
            Text("Total screen time usage time")
                .font(.callout)
                .foregroundColor(.secondary)
            Text(activityReport.totalDuration.toString())
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 8)
            List {
                Section {
                    ForEach(activityReport.apps) { eachApp in
                        ListRow(eachApp: eachApp)
                    }
                } footer: {
                    /**
                     Pickup에 대한 참고 아티클
                     - 자료들을 조사해보면 Pickup은 단순 화면을 켠 횟수로 계산되는 것이 아니라, Apple에서 설정한 특정 기준의 상호작용이 이루어졌을 때 카운트가 된다고 합니다.
                     - 그렇기 때문에 앱 모니터링 시간이 계산되어도 화면 깨우기 횟수는 카운트되지 않는 경우도 많이 확인할 수 있습니다.
                     https://www.imobie.com/support/what-are-pickups-in-screen-time.htm#q1
                     https://www.theverge.com/2018/9/17/17870126/ios-12-screen-time-app-limits-downtime-features-how-to-use
                     */
                    Text(
                    """
                    [Wake screen] refers to the number of times the dark screen has been turned on to use the app.
                    👉 You can also check the number of screen wake-ups in the [Settings] app → [Screen Time] → [View all activities].
                    """
                    )
                }
            }
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                
                if let token = eachApp.token {
                    Label(token)
                        .labelStyle(.iconOnly)
                        .offset(x: -6)
                }
                Text(eachApp.displayName)
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Wake screen")
                            .font(.system(size: 11.0))
                            .foregroundColor(.secondary)
                            .frame(width: 86, alignment: .leading)
                            
                        Text("\(eachApp.numberOfPickups) time(s)")
                            .font(.system(size: 12.0))
                            .fontWeight(.semibold)
                            .frame(minWidth: 54, alignment: .trailing)
                    }
                    HStack(spacing: 4) {
                        Text("Monitoring Time")
                            .font(.system(size: 11.0))
                            .foregroundColor(.secondary)
                            .frame(width: 86, alignment: .leading)
                        Text(String(eachApp.duration.toString()))
                            .font(.system(size: 12.0))
                            .fontWeight(.semibold)
                            .frame(minWidth: 54, alignment: .trailing)
                    }
                }
            }
//            HStack {
//                Text("App ID")
//                    .font(.footnote)
//                    .foregroundColor(.secondary)
//                Text(eachApp.id)
//                    .font(.footnote)
//                    .foregroundColor(.secondary)
//                    .bold()
//                Spacer()
//            }
        }
        .background(.clear)
    }
}

