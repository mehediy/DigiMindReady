//
//  AchievementView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/21/24.
//

import SwiftUI

struct AchievementView: View {
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {

                ProfileProgressView()
                    .padding(.top, 24)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .frame(height: 5)
                    .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                    .padding(.vertical)
                
                ForEach(BadgeType.allCases, id:\.self) { badgeType in

                    AchievementRowView(achievement: Float.random(in: 0...100), badgeType: badgeType)
                }

            }
        }

    }
}


struct AchievementRowView: View {
    
    let achievement: Float
    let badgeType: BadgeType
    let skillLevel: SkillLevel
    
    init(achievement: Float, badgeType: BadgeType) {
        self.achievement = achievement
        self.badgeType = badgeType
        self.skillLevel = SkillLevel(achievement: achievement)
    }
    
    
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {

                HStack(alignment: .center) {
                    Text(badgeType.progressTitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        
                    Spacer()
                    
                    Text("\(Int(ceil(achievement)))%")
                        .font(.caption)
                        .fontWeight(.semibold)

                    
                }.padding(.horizontal)

                
                HStack(alignment: .center) {
                    ForEach(1...5, id: \.self) { count in
                        
                        Image(BadgeData.getBadgeImageName(type: badgeType, star: count))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .opacity( (count <= skillLevel.starCount) ? 1.0 : 0.0)
                    }
                }
            }
        }
        .padding(.bottom, 28)
    }
}

#Preview {
    AchievementView()
}
