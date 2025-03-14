//
//  ProfileProgressView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/21/24.
//

import SwiftUI

struct ProfileProgressView: View {
    
    var showAllAchievementsButton: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {

            HStack(alignment: .center) {
                Text("Overall Progress")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("Secondary"))

                    
                Spacer()
                
                Text("\(Int(ceil(55.0)))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("Secondary"))

                
            }.padding(.horizontal)

            
            HStack {
                VStack {
                    Image(BadgeData.getBadgeImageName(achievement: 25))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity) // Each image takes up half of the available width
                        .frame(height: 55)
                    
                    Text("Badge Earned")
                        .font(.subheadline)
                }
                

                Divider()
                    .frame(height: 50)
                
                VStack {
                    Image(BadgeData.getTrophyImageName(achievement: 25))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                    

                    Text("Trophy Awarded")
                        .font(.subheadline)
                }
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.05))
            .edgesIgnoringSafeArea(.all)
            
            if showAllAchievementsButton {
                HStack {
                    Text("Click to See all Achievements")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 12.0))
                .fontWeight(.semibold)
                .foregroundStyle(Color("Secondary"))
                .padding(.top, 4)
                .padding(.horizontal)
            }


        }
    }
}


#Preview {
    ProfileProgressView()
}


