//
//  ProfileView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct ProfileView: View {
    
    var profileModels = ProfileType.profileModels
    
    @Binding var popToRootTab: Tab
    @State private var isPresentingSurveyFullScreenView = false
    @State var choosenLanguage: Language = LocalizationService.shared.currentLanguage
    @EnvironmentObject private var appRootManager: AppRootManager
    //@StateObject private var coordinator: Coordinator
    
    @State private var navigationPath = NavigationPath()
    
    init(popToRootTab: Binding<Tab>) {
        _popToRootTab = popToRootTab
        
//        let coordinator = Coordinator(self)
//        self._coordinator = StateObject(wrappedValue: coordinator)
    }
    
    mutating func update(for language: Language) {
        
        self.choosenLanguage = language
        
        for indx in 0..<profileModels.count {
            for itmIndx in 0..<profileModels[indx].items.count {
                let localizedTitle = profileModels[indx].items[itmIndx].titleKey.localized()
                profileModels[indx].updateTitle(localizedTitle, item: profileModels[indx].items[itmIndx])
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var body: some View {
        
        NavigationView{
            
            List {
                
                Section(header: NavigationLink(destination: {
                    AchievementView()
                        .navigationTitle("My Achievements")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                }, label: {
                    ProfileHeaderView()
                    
                })
                    .textCase(.none)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                            
//                            ProfileHeaderView()
//                    .textCase(.none)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                , footer: EmptyView().frame(height: 0)) {
                    EmptyView()
                }
                
                ForEach(profileModels) { profileModel in
                    Section(header: 
                                Text(profileModel.group).padding(.top, 16)
                    ) {
                        ForEach(profileModel.items) { item in
                            
                            if item.type.isNavigationLink {
                                
                                NavigationLink {
                                    switch item.type {
                                    case .profile:
                                        UserProfileView()
                                    case .contactUs:
                                        ContactUsView()
                                            .navigationTitle("Contact Us")
                                            .navigationBarTitleDisplayMode(.inline)
                                            .toolbarBackground(Color("Secondary"), for: .navigationBar)
                                            .toolbarBackground(.visible, for: .navigationBar)
                                            .toolbarColorScheme(.dark, for: .navigationBar)
                                    case .aboutUs:
                                        AboutUsView()
                                            .navigationTitle("Contact Us")
                                            .navigationBarTitleDisplayMode(.inline)
                                            .toolbarBackground(Color("Secondary"), for: .navigationBar)
                                            .toolbarBackground(.visible, for: .navigationBar)
                                            .toolbarColorScheme(.dark, for: .navigationBar)
                                    default:
                                        EmptyView()
                                            .navigationTitle("")
                                            .navigationBarTitleDisplayMode(.inline)
                                            .toolbarBackground(Color("Secondary"), for: .navigationBar)
                                            .toolbarBackground(.visible, for: .navigationBar)
                                            .toolbarColorScheme(.dark, for: .navigationBar)
                                    }
                                } label: {
                                    
                                    let viewData = ProfileRow.ViewData(
                                        title: item.titleKey.localized(choosenLanguage),
                                        subtitle: item.text,
                                        foregroundColor: item.type == .logout ? .red : Color("Secondary")
                                    )
                                    
                                    ProfileRow(
                                        profileItem: item,
                                        data: viewData,
                                        pressed: {
                                            switch item.type {
                                            //case .aboutUs:
                                                //let url: NSURL = URL(string: "https://facultyweb.kennesaw.edu/mramos18/index.php")! as NSURL
                                                //UIApplication.shared.open(url as URL)
                                            default:
                                                print(item.type)
                                                break
                                            }
                                        }
                                    )
                                }
                                
                                
                            } else {
                                
                                switch item.type {
                                /*case .language:
                                    ProfileLanguageRow(
                                        title: item.titleKey) { newLanguage in
                                            print(newLanguage)
                                            //update(for: newLanguage)
                                            self.choosenLanguage = newLanguage
                                        }*/
                                    
                                default:
                                    
                                    let viewData = ProfileRow.ViewData(
                                        title: item.titleKey.localized(choosenLanguage),
                                        subtitle: item.text,
                                        foregroundColor: item.type == .logout ? .red : Color("Secondary")
                                    )
                                    
                                    ProfileRow(
                                        profileItem: item,
                                        data: viewData,
                                        pressed: {
                                            switch item.type {
                                            case .survey:
                                                isPresentingSurveyFullScreenView.toggle()
                                            case .logout:
                                                appRootManager.logout()
                                            default:
                                                break
                                            }
                                        },
                                        showAccessoryView: item.type == .survey
                                    )
                                }
                                
                            }
                            
                        }
                        //End of ForEach
                        
                    }
                }

            }
            .listStyle(GroupedListStyle())
            .listSectionSpacing(0)
            .background(Color.white)
            .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 24, topTrailing: 24)))
            
            .background(VStack(spacing: .zero) { Color("Secondary"); Color.white })
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("Secondary"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        print("Pressed")
                    } label: {
                        Image(systemName: "bell.fill")
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingSurveyFullScreenView) {
                //var survey: Survey = SampleSurvey
                //SurveyView(survey: survey, delegate: self.makeCoordinator()).preferredColorScheme(.light)
            }
        }
    }
    
    class Coordinator: NSObject, ObservableObject {
        
        var parent: ProfileView?
        
        init(_ parent: ProfileView? = nil) {
            self.parent = parent
        }
        
//        func surveyCompleted(with survey: Survey) {
//            let jsonUrl = URL.documentsDirectory().appendingPathComponent("survey_filled_" + String(Int.random(in: 0...100)) + ".json")
//            try? Survey.SaveToFile(survey: survey, url: jsonUrl)
//            print( " Saved survey to: \n" , jsonUrl.path )
//            parent?.isPresentingSurveyFullScreenView = false
//        }
        
        func surveyDeclined() {
            parent?.isPresentingSurveyFullScreenView = false
        }
        
        func surveyRemindMeLater() {
            parent?.isPresentingSurveyFullScreenView = false
        }
    }
}



#Preview {
    let binding: Binding<Tab> = .constant(.home)
    return ProfileView(popToRootTab: binding)
}





/*struct ProfileLanguageRow: View {
    var title: String
    var onChanged: ((Language) -> Void)?
    
    @AppStorage(LocalizationService.languageOverrideKey)
    var choosenLanguage: Language = LocalizationService.shared.currentLanguage
    
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Text(title.localized(choosenLanguage))
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.accentColor )
                .padding(.top, 8)
            
            
            Spacer(minLength: 12)
            
            EnumPicker(selected: $choosenLanguage, title: "Choose Language") { enumValue in
                Text(enumValue.name)
            }
            .onChange(of: choosenLanguage, { _, newValue in
                choosenLanguage = newValue
                LocalizationService.shared.setLanguage(newValue)
            })
            .pickerStyle(SegmentedPickerStyle())
            //.padding(.bottom, 8)
            .frame(width: 180)
        }

    }
}*/


struct ProfileRow: View {
    var profileItem: ProfileItem
    var data: ViewData
    var pressed: (() -> Void)?
    var showAccessoryView: Bool = false
    
    var body: some View {
        Button(action: {
            if (self.pressed == nil) {
                return
            }
            self.pressed!()
        }) {
            HStack() {

                VStack(alignment: .leading) {
                    Text(data.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor( data.foregroundColor )
                    if let subtitle = data.subtitle {
                        Text(subtitle)
                            .lineLimit(2)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }

                }
                
                if showAccessoryView {
                    Spacer()
                    //NavigationLink.empty
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .font(Font.system(size: 13, weight: .semibold, design: .default))
                        .foregroundColor(Color(red: 0.771, green: 0.771, blue: 0.779))
                }
            }
        }
        .padding(.vertical, 2)
    }
    
    struct ViewData {
        var id = UUID()
        var title: String
        var subtitle: String?
        var foregroundColor: Color?
    }
}


struct EmptyFooterView: View {
    var body: some View {
        Color.clear.frame(height: 0)  // Minimized footer to reduce section spacing
    }
}

