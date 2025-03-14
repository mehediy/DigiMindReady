//
//  SignupScreen.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject private var viewModel = SignupScreenViewModel()
    
    var onSuccesfulSignupEvent: () -> Void
    
    //MARK:- PROPERTIES
    @State private var username = ""
//    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            
            // Welcome
            VStack(spacing: 8){
                Text("signup.text.register".localized())
                    .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 32, fontColor: .accentColor))
                Text("signup.text.create.new.account")
                    .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 17, fontColor: Color("Secondary")))
            }
            .padding(.top, 8)
            
            Spacer()
            
            
            // Form
            VStack(spacing: 15){
                VStack(alignment: .center, spacing: 30){
                    VStack(alignment: .center) {
                        CustomTextfield(placeholder:
                                            Text("signup.text.username".localized()),
                                        iconImage: Image(systemName: "person"),
                                        fontName: "RobotoSlab-Light",
                                        fontSize: 17,
                                        fontColor: Color.gray,
                                        username: $username)
                        Divider()
                            .background(Color.gray)
                    }
                    
//                    VStack(alignment: .center) {
//                        CustomTextfield(placeholder:
//                                            Text("signup.text.email".localized()),
//                                        fontName: "RobotoSlab-Light",
//                                        fontSize: 17,
//                                        fontColor: Color.gray,
//                                        username: $email)
//                        Divider()
//                            .background(Color.gray)
//                    }
                    
                    VStack(alignment: .center) {
                        CustomSecureField(placeholder:
                                            Text("signup.text.password".localized()),
                                          iconImage: Image(systemName: "lock"),
                                          fontName: "RobotoSlab-Light",
                                          fontSize: 17,
                                          fontColor: Color.gray,
                                          password: $password)
                        Divider().background(Color.gray)
                    }
                    VStack(alignment: .center) {
                        CustomSecureField(placeholder:
                                            Text("signup.text.confirm.password".localized()),
                                          iconImage: Image(systemName: "lock"),
                                          fontName: "RobotoSlab-Light",
                                          fontSize: 17,
                                          fontColor: Color.gray,
                                          password: $confirmPassword)
                        Divider()
                            .background(Color.gray)
                    }
                }
            }
            .padding(.horizontal,35)
            
            
            //Button
            Button(action: {
                //viewModel.isQuizPresentingFullScreen = true
                onSuccesfulSignupEvent()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("signup.button.signup".localized())
                    .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                    .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: .accentColor, buttonRadius: 26))
            }
            .padding(.horizontal,35)
            .padding(.top,30)
            
            Spacer()
            
            //SignUp
            HStack{
                Text("signup.text.have.account".localized())
                    .modifier(CustomTextM(fontName: "WorkSans-Light", fontSize: 15, fontColor: Color.gray))
                Button(action: { self.presentationMode.wrappedValue.dismiss() }){
                    Text("signup.button.signin".localized())
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 15, fontColor: Color("Secondary")))
                }
                
            }
            .padding(.bottom, 20)
            
        }
        .background(Color.background)
    }
}


struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen(onSuccesfulSignupEvent: {
            print("onSuccesfulSignupEvent")
        })
    }
}
