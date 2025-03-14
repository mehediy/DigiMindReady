//
//  LoginScreen.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import SwiftUI

struct LoginScreen: View {
    
    //MARK:- PROPERTIES
    @State private var username = ""
    @State private var password = ""
    
    @StateObject private var viewModel = LoginScreenViewModel()
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @AppStorage(LocalizationService.languageOverrideKey)
    var choosenLanguage: Language = LocalizationService.shared.currentLanguage
    
    var body: some View {
        
        NavigationStack {
            
            VStack{
                
                //Logo
                Image("AppLogo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.top, 28)
                
                // Welcome
                VStack(spacing: 8){
                    Text("login.text.hello".localized(choosenLanguage))
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 32, fontColor: Color("Secondary")))
                    Text("login.text.enterdetail".localized(choosenLanguage))
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 17, fontColor: Color.black))
                }
                .padding(.top, 8)
                
                Spacer()

                // Form
                VStack(spacing: 15){
                    VStack(alignment: .center, spacing: 30){
                        VStack(alignment: .center) {
                            CustomTextfield(placeholder:
                                                Text("login.text.username".localized(choosenLanguage)),
                                            iconImage: Image(systemName: "person"),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 17,
                                            fontColor: Color.gray,
                                            username: $username)
                            Divider()
                                .background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            CustomSecureField(placeholder:
                                                Text("login.text.password".localized(choosenLanguage)),
                                              iconImage: Image(systemName: "lock"),
                                              fontName: "RobotoSlab-Light",
                                              fontSize: 17,
                                              fontColor: Color.gray,
                                              password: $password)
                            Divider()
                                .background(Color.gray)
                        }
                    }
                    HStack{
                        Spacer()
                        Button(action: {}){
                            Text("login.button.forgot.password".localized(choosenLanguage))
                                .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 13, fontColor: Color.gray))
                        }
                    }
                }
                .padding(.horizontal,35)
                
                
                //Login Button
                Button(action: {
                    withAnimation(.spring()) {
                        appRootManager.currentRoot = .home
                    }
                }){
                    Text("login.button.login".localized(choosenLanguage))
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                        .modifier(LoginButtonStyle(buttonHeight: 52, buttonColor: .accentColor, buttonRadius: 26))
                }
                .padding(.horizontal,35)
                .padding(.top,30)
                
                
                Spacer()
                
                //SignUp
                HStack{
                    Text("login.text.dont.have.account".localized(choosenLanguage))
                        .modifier(CustomTextM(fontName: "WorkSans-Light", fontSize: 15, fontColor: Color.gray))
                    NavigationLink {
                        SignupScreen(onSuccesfulSignupEvent:  {
                            viewModel.isQuizPresentingFullScreen = true
                        })
                    } label: {
                        Text("login.button.signup".localized(choosenLanguage))
                            .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 15, fontColor: Color("Secondary")))
                    }
                }
                .padding(.bottom, 20)
                
                
                /*EnumPicker(selected: $choosenLanguage, title: "Choose Language") { enumValue in
                    Text(enumValue.name)
                }
                .onChange(of: choosenLanguage, { _, newValue in
                    choosenLanguage = newValue
                    LocalizationService.shared.setLanguage(newValue)
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 40)
                .padding(.bottom, 20)*/
                
            }
            .background(Color.background)
        }
        .fullScreenCover(isPresented: $viewModel.isQuizPresentingFullScreen) {
            let quizSurvey = SurveyHelper.ProfileQuizSurvey
            SurveyView(survey: quizSurvey, delegate: viewModel).preferredColorScheme(.light)
        }
    }

}

#Preview {
    LoginScreen()
}


struct CustomTextM: ViewModifier {
    //MARK:- PROPERTIES
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}

struct LoginButtonStyle: ViewModifier {
    //MARK:- PROPERTIES
    let buttonHeight: CGFloat
    let buttonColor: Color
    let buttonRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: buttonHeight)
            .background(buttonColor)
            .cornerRadius(buttonRadius)
    }
}

