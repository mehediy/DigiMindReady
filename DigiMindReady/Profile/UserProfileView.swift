//
//  UserProfileView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var isEditMode = false
    @State private var userProfile: UserProfile = {
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        let people = try! decoder.decode(UserProfile.self, from: jsonData)
        print(people)
        return people
    }()

    var body: some View {
//        NavigationView {
            VStack {
                
                Image("profileImage") // Replace with the name of your profile image asset
                    .resizable()
                    .frame(width: 120, height: 120) // Adjust the size as needed
                    .clipShape(Circle()) // Clip the image in a circular shape
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3) // Add a white border
                    )
                    .shadow(radius: 7) // Add a shadow effect
                    .padding(.top, 20) // Adjust the top padding as needed
                
                // Add other content below the profile picture
                Text(userProfile.fullName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Form {
                    Section(header: Text("Personal Information")) {
                        
                        if isEditMode {
                            LabelInputRow(label: "Username", value: $userProfile.username)
                            LabelInputRow(label: "User Type", value: $userProfile.userType)
                            LabelInputRow(label: "Email", value: $userProfile.email)
                            LabelInputRow(label: "Phone", value: $userProfile.phone)
                            LabelInputRow(label: "Birthdate", value: $userProfile.birthdate)
                        } else {
                            LabelValueRow(label: "Username", value: userProfile.username)
                            LabelValueRow(label: "User Type", value: userProfile.userType)
                            LabelValueRow(label: "Email", value: userProfile.email)
                            LabelValueRow(label: "Phone", value: userProfile.phone)
                            LabelValueRow(label: "Birthdate", value: userProfile.birthdate)
                        }
            
                    }
                    
                    Section(header: Text("Address")) {
                        
                        if isEditMode {
                            LabelInputRow(label: "Street", value: $userProfile.address)
                            LabelInputRow(label: "City", value: $userProfile.city)
                            LabelInputRow(label: "State", value: $userProfile.state)
                            LabelInputRow(label: "Postal Code", value: $userProfile.postalCode)
                            LabelInputRow(label: "Country", value: $userProfile.country)
                        } else {
                            LabelValueRow(label: "Street", value: userProfile.address)
                            LabelValueRow(label: "City", value: userProfile.city)
                            LabelValueRow(label: "State", value: userProfile.state)
                            LabelValueRow(label: "Postal Code", value: userProfile.postalCode)
                            LabelValueRow(label: "Country", value: userProfile.country)
                        }
                        
                    }
                    
//                    if isEditMode {
//                        Section {
//                            TextField("Username", text: $editedProfile.user)
//                            TextField("Email", text: $editedProfile.email)
//                            // Add editable fields here...
//                        }
//                    }
                }
            }
            .navigationBarTitle("My Profile Details", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    isEditMode.toggle()
                }) {
                    Text(isEditMode ? "Done" : "Edit")
                }
            )
//        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}



struct LabelValueRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.regular)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

struct LabelInputRow: View {
    let label: String
    let value: Binding<String>

    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
            Spacer()
            
            VStack(alignment: .leading, spacing: 5) {
                TextField(label, text: value)
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.trailing)

                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.gray.opacity(0.3))
            }

        }
        .padding(.vertical, 2)
    }
}


struct UserProfile: Codable {
    let userID: Int
    var username, userType, firstName, lastName: String
    var email, phone: String
    var birthdate, address, city, state: String
    var postalCode, country: String
    var additionalUserField: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username
        case userType = "user_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phone
        case birthdate, address, city, state
        case postalCode = "postal_code"
        case country
        case additionalUserField = "additional_user_field"
    }
}


let jsonString =
"""
{
    "user_id": 123,
    "username": "john_doe",
    "user_type": "patient",
    "email": "john.doe@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "birthdate": "1990-05-15",
    "phone": "(470) 555-1234",
    "address": "123 Main Street",
    "city": "Anytown",
    "state": "GA",
    "postal_code": "12345",
    "country": "United States",
    "additional_user_field": "Additional field specific to the user type"
  }
"""
