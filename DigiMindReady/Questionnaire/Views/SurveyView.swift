//
//  SurveyView.swift
//  SwiftSurvey
//
//  Created by CC Laan on 6/13/21.
//

import SwiftUI
import Combine


protocol SurveyViewDelegate : AnyObject {
    func surveyCompleted( with survey : Survey )
    func surveyDeclined()
    func surveyRemindMeLater()
}


struct SurveyPageInfo {
    let introPageImage: String
    let introPageTitle: String
    let introPageMessage: String
    let introPageActionText: String
    
    let completePageActionText: String
}


struct SurveyView: View {
    
    @ObservedObject var survey : Survey
    let pageInfo: SurveyPageInfo
    @State var currentQuestion : Int = 0
    
    enum SurveyState {
        case showingIntroScreen
        case taking
        case complete
    }
    
    @State var surveyState : SurveyState = .showingIntroScreen
    @State var processing = false
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var delegate : SurveyViewDelegate?
    
    init(survey: Survey, pageInfo: SurveyPageInfo? = nil, delegate: SurveyViewDelegate? = nil) {
        self.survey = survey
        self.delegate = delegate
        
        if let pageInfo = pageInfo {
            self.pageInfo = pageInfo
        } else {
            let info = SurveyPageInfo(
                introPageImage: "AppLogoMono",
                introPageTitle: "Welcome to DigiMindReady",
                introPageMessage: "Let's personalize your experience! Please answer a few quick questions to help us tailor suggestions just for you. Rest assured, all your data never leaves and stays secure on your device.",
                introPageActionText: "Take the Quiz",
                completePageActionText: "Submit Answers")
            self.pageInfo = info
        }
    }
    
    
    var body: some View {
        
        if surveyState == .showingIntroScreen {
            
            // TODO: break out into IntroView
            VStack {
                
                Image(pageInfo.introPageImage).resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 16, trailing: 0))
                
                Text(pageInfo.introPageTitle).font(.title)
                    .foregroundColor(Color("Title"))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                
                Text(pageInfo.introPageMessage)
                    .font(.system(size: 15, weight: .regular))
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
                    .multilineTextAlignment(.center)
                
                HStack {
                    
                    Button(action: { self.remindMeLaterTapped() }, label: {
                        Text("Remind Me Later")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 15.dynamic, weight: .semibold))
                            .padding(6.0)
                    }).buttonStyle(CustomButtonStyle(bgColor: Color(.systemGray5)))
                        .padding(5)
                    
                    Button(action: { self.takeSurveyTapped() }, label: {
                        Text(pageInfo.introPageActionText)
                            .font(.system(size: 15.dynamic, weight: .semibold))
                            .padding(6.0)
                    }).buttonStyle(CustomButtonStyle(bgColor: Color("Secondary")))
                        .padding(5)
                    
                    
                }.padding()
                
                Button(action: { self.noThanksTapped() }, label: {
                    Text("No Thanks. I'm good")
                        .font(.system(size: 15.dynamic, weight: .regular))
                }).padding()
            }
        }
        else if surveyState == .complete {
            //if true {
            
            VStack {
                
                Text("👍").font(.system(size: 120)).padding(EdgeInsets(top: 60, leading: 0, bottom: 20, trailing: 0))
                
                Text("Thanks!").font(.system(size: 45)).multilineTextAlignment(.center)
                
                Text("We really appreciate your feedback!").font(.title).padding(30).multilineTextAlignment(.center)
                
                ProgressView()
                    .opacity( processing ? 1.0 : 0.0 )
                
                Button(action: { submitSurveyTapped() }, label: {
                    Text(pageInfo.completePageActionText)
                        .font(.system(size: 15.dynamic, weight: .semibold))
                        .padding(6.0)
                }).buttonStyle(CustomButtonStyle(bgColor: Color("Secondary"))).padding()
                //.enabled( !self.processing )
                
                
                Button(action: { self.restartSurveyTapped() }, label: {
                    Text("Retake Survey")
                }).padding()
            }
            
        } else {
            
            VStack(spacing:0) {
                
                Text("Question ".appendingFormat("%i / %i", currentQuestion+1, self.survey.questions.count))
                    .bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 2, trailing: 0))
                    .frame(maxWidth: .infinity)
                
                
                ForEach(survey.questions.indices, id: \.self) { i in
                    
                    if i == currentQuestion {
                        
                        ScrollViewReader { proxy in
                            ScrollView {
                                
                                if let question = survey.questions[currentQuestion] as? MultipleChoiceQuestion {
                                    MultipleChoiceQuestionView(question: question, scrollProxy: proxy )
                                } else if let question = survey.questions[currentQuestion] as? BinaryQuestion {
                                    BinaryChoiceQuestionView(question: question, onChoiceMade: { nextTapped() })
                                } else if let question = survey.questions[currentQuestion] as? ContactFormQuestion {
                                    ContactFormQuestionView(question: question)
                                } else if let question = survey.questions[currentQuestion] as? CommentsFormQuestion {
                                    CommentsFormQuestionView(question: question)
                                } else if let question = survey.questions[currentQuestion] as? InlineMultipleChoiceQuestionGroup {
                                    InlineMultipleChoiceQuestionGroupView(group: question)
                                    
                                }
                                
                                // Space filling rect for extra scroll with transparent prev/next bar
                                //Rectangle().fill(Color.clear).frame(width: 2, height: 2).id(bottomID)
                                
                            }
                            .background(Color.white)
                            .keyboardAware()
                            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color(.systemGray4)), alignment: .top)
                        }
                        
                        
                    }
                }
                
                
                HStack() {
                    Button(action: { previousTapped() }, label: {
                        Text("Previous").foregroundColor(Color(.secondaryLabel)).bold()
                    }).buttonStyle(CustomButtonStyle(bgColor: Color(.systemGray5)))
                    
                    Spacer()
                    Button(action: { nextTapped() }, label: {
                        Text("Next").bold()
                    }).buttonStyle(CustomButtonStyle(bgColor: Color("Secondary")))
                    
                }.padding(EdgeInsets(top: 12, leading: 22, bottom: 24, trailing: 22))
                
                    .background(Color(.systemGray6))
                    .edgesIgnoringSafeArea( [.leading, .trailing] )
                
                
                
            }
            .background(Color.white)
            
            /*
             // For semi transparent overlay of prev/next bar to show more content
             // underneat that is scrollable ...
             // downside is the 'other' choice expands to have text field that is hidden
             .overlay(
             
             HStack() {
             
             Button(action: { previousTapped() }, label: {
             Text("Previous").foregroundColor(Color(.secondaryLabel)).bold()
             }).buttonStyle(CustomButtonStyle(bgColor: Color(.systemGray5)))
             
             Spacer()
             Button(action: { nextTapped() }, label: {
             Text("Next").bold()
             }).buttonStyle(CustomButtonStyle(bgColor: Color.blue))
             
             }.padding(18)
             
             .background(Color(.systemGray6).opacity(0.75))
             .edgesIgnoringSafeArea( [.leading, .trailing] )
             , alignment: .bottom
             )
             */
            .edgesIgnoringSafeArea( .bottom )
            //.background(Color.red)
            
        }
        
    }
    
    private func closeKeyboard() {
        UIApplication.shared.endEditing()
    }
    
    
    func previousTapped() {
        var i = self.currentQuestion
        
        while i > 0 {
            i = i - 1
            
            let question = survey.questions[i]
            if question.isVisible(for: survey) {
                self.currentQuestion = i
                break
            }
        }
        
    }
    
    func nextTapped() {
        
        if self.currentQuestion == survey.questions.count-1 {
            // Survey done
            self.setSurveyComplete()
        } else {
            //self.currentQuestion += 1
            for i in (self.currentQuestion+1)..<self.survey.questions.count {
                let question = survey.questions[i]
                if question.isVisible(for: survey) {
                    self.currentQuestion = i
                    break
                }
                
                if i == self.survey.questions.count-1 {
                    self.setSurveyComplete()
                }
            }
        }
    }
    
    func submitSurveyTapped() {
        
        self.processing = true
        
        var meta : [String : String] = [:]
        
#if DEBUG
        meta["debug"] = "true"
#endif
        
        meta["app_version"] = Bundle.main.releaseVersionNumber
        meta["build"] = Bundle.main.buildVersionNumber
        
        survey.metadata = meta
        
        
        self.delegate?.surveyCompleted(with: self.survey)
        
        self.processing = false
        
    }
    
    func takeSurveyTapped() {
        self.surveyState = .taking
    }
    
    func noThanksTapped() {
        self.delegate?.surveyDeclined()
    }
    
    func remindMeLaterTapped() {
        self.delegate?.surveyRemindMeLater()
    }
    
    func restartSurveyTapped() {
        
        self.currentQuestion = 0
        self.surveyState = .taking
        
    }
    
    func setSurveyComplete() {
        
        self.surveyState = .complete
        
    }
    
}

struct SurveyView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SurveyView(survey: SurveyHelper.ProfileQuizSurvey).preferredColorScheme(.light)
        
    }
}
