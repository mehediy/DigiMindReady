//
//  ContactUsView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 1/17/24.
//

import SwiftUI

struct ContactUsView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Get in Touch")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("We'd love to hear from you! Whether you have a question about our mHealth project, or anything else, our research team is ready to answer all your questions.")
                    .font(.body)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Contact Information")
                        .font(.title2)
                        .fontWeight(.bold)


                    Link(destination: URL(string: "mailto:nsakib1@kennesaw.edu")!) {
                        HStack {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            Text("Email: ")
                                .foregroundStyle(Color.black)
                            Text("nsakib1@kennesaw.edu")
                                .foregroundStyle(Color.accentColor)
                        }
                    }

                    Link(destination: URL(string: "tel:4705783803")!) {
                        HStack {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            Text("Phone: ")
                                .foregroundStyle(Color.black)
                            Text("(470) 578-3803")
                                .foregroundStyle(Color.accentColor)
                        }
                    }

                    HStack {
                        Image(systemName: "map")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                        Text("Address: 1100 South Marietta Pkwy SE, Marietta, GA 30060")
                    }
                }

                Divider()

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Contact Us", displayMode: .inline)
    }

    func sendMessage() {
        // Implement message sending logic
        print("Message sent: \(message)")
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
