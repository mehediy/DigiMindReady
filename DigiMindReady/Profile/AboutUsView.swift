//
//  AboutUsView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 1/17/24.
//

import SwiftUI

struct AboutUsView: View {
    
    let urlString = "https://www.kennesaw.edu/ccse/labs/mhealth-lab.php"
    @State private var isCopied: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {

                Text("mHealth Lab")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Primary"))

                Text("Welcome to the mHealth Research Lab at Kennesaw State University's College of Computing and Software Engineering, led by Dr. Nazmus Sakib. Our dedicated group focuses on developing cutting-edge mHealth systems, spanning web, iOS, and Android applications, to tackle pressing healthcare challenges in collaboration with a wide range of experts. Our interest lies in Healthcare Informatics, AI and Machine Learning for Healthcare, Medical and Healthcare Security and Privacy, Health Disparities and Social Determinants of Health, Optimization Research for Healthcare, Alzheimer's and Dementia, and Infant Biomechanics and Development. Join us as we work towards revolutionizing healthcare through innovative research and solutions!")
                    .font(.body)
                
                
                Text("For more information visit our website:")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text(urlString)
                    .font(.footnote)
                
                 Button(action: {
                     UIPasteboard.general.string = urlString
                     self.isCopied = true
                     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                         self.isCopied = false
                     }
                 }) {
                     Text("Copy Link")
                 }
                 .buttonStyle(.borderedProminent)

                if isCopied {
                    Text("Copied!")
                        .foregroundColor(.green)
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("About Us", displayMode: .inline)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
