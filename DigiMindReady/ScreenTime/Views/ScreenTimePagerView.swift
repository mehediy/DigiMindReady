//
//  MainTabView.swift

import SwiftUI

struct ScreenTimePagerView: View {
    
    @StateObject var vm = ScreenTimePagerViewModel()
    @State var selection = 1
    
    @MainActor var body: some View {
        PagerTabStripView(selection: $vm.tabIndex) {
            
            ForEach(ScreenTimePages.allCases, id: \.self) { page in
                page.view
                    .pagerTabItem(tag: page.hashValue) {
                        CustomNavBarItem(title: page.labelInfo.text, imageName: page.labelInfo.icon, selection: $selection, tag: page.hashValue)
                    }
                    .onAppear {
                        
                        if page == .report {
                            
                        }
//                        homeModel.isLoading = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            homeModel.isLoading = false
//                        }
                    }
            }
        }
        .pagerTabStripViewStyle(.barButton(tabItemHeight: 68, padding: EdgeInsets(), indicatorViewHeight: 3,
        indicatorView: {
            Rectangle().fill(Color("Primary")).cornerRadius(5)
        }))
    }
    
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}



private struct CustomNavBarItem<SelectionType>: View where SelectionType: Hashable {

    @EnvironmentObject private var pagerSettings: PagerSettings<SelectionType>

    let unselectedColor = Color(.systemGray)
    let selectedColor = Color.black
    
    let title: String
    let image: Image
    @Binding var selection: SelectionType
    let tag: SelectionType

    init(title: String, imageName: String, selection: Binding<SelectionType>, tag: SelectionType) {
        self.tag = tag
        self.title = title
        self.image = Image(systemName: imageName)
        _selection = selection
    }

    @MainActor var body: some View {
        VStack {
            image
                .renderingMode(.template)
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(unselectedColor.interpolateTo(color: selectedColor,
                                                               fraction: pagerSettings.transition.progress(for: tag)))
            Text(title.uppercased())
                .foregroundColor(unselectedColor.interpolateTo(color: selectedColor,
                                                               fraction: pagerSettings.transition.progress(for: tag)))
                .fontWeight(.semibold)
                .font(.system(size: 13))
        }
        .animation(.default, value: selection)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
