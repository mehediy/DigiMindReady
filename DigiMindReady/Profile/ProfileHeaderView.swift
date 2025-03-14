//
//  ProfileHeaderView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/21/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            //ProfileImageView()
            Text("Hello, John Doe!")
                .font(.title)
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 0)
            
            ProfileProgressView(showAllAchievementsButton: true)
        }.padding(.vertical, 0)
    }
}


struct ProfileImageView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(Color("Secondary"))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                )
                .shadow(radius: 7)
            
            Text("John Doe")
                .font(.title)
                .padding(.horizontal, 8)
        }
        .padding()
    }
}


#Preview {
    ProfileHeaderView()
}
