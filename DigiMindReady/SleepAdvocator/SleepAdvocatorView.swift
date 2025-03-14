//
//  SleepAdvocatorView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 6/14/24.
//

import SwiftUI
import Darwin
//import llmfarm_core_cpp

struct SleepAdvocatorView: View {
    @State var add_chat_dialog = false
    @State var edit_chat_dialog = false
    @State var current_detail_view_name:String? = "Chat"
    @State var model_name = ""
    @State var title = ""
    @StateObject var aiChatModel = AIChatModel()
    @StateObject var fineTuneModel = FineTuneModel()
    @StateObject var orientationInfo = OrientationInfo()
    @State var isLandscape:Bool = false
    @State private var chat_selection: Dictionary<String, String>?
    @State var after_chat_edit: () -> Void = {}
    @State var tabIndex: Int = 0
    //    var set_res = setSignalHandler()
    @Environment(\.dismiss) var dismiss
    
    
    func close_chat() -> Void{
        aiChatModel.stop_predict()
    }
    
    
    var body: some View {
        
//        NavigationLink {
//
//        } label: {
//            
//        }

        
        NavigationSplitView()  {
            ChatListView(tabSelection: .constant(0),
                         model_name:$model_name,
                         title: $title,
                         add_chat_dialog:$add_chat_dialog,
                         close_chat:close_chat,
                         edit_chat_dialog:$edit_chat_dialog,
                         chat_selection:$chat_selection,
                         after_chat_edit: $after_chat_edit
            )
            .environmentObject(fineTuneModel)
            .environmentObject(aiChatModel)
            .frame(minWidth: 250, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.app")
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .foregroundColor(Color(red: 0.78, green: 0.02, blue: 0.13))
                    }
                }
            }
            
        } detail: {
            ChatView(
                model_name: $model_name,
                chat_selection: $chat_selection,
                title: $title,
                close_chat:close_chat,
                add_chat_dialog:$add_chat_dialog,
                edit_chat_dialog:$edit_chat_dialog).environmentObject(aiChatModel).environmentObject(orientationInfo)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }
        .navigationSplitViewStyle(.balanced)
        .background(.ultraThinMaterial)
    }
    
}


#Preview {
    SleepAdvocatorView()
}
