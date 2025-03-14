//
//  ScheduleView.swift


import SwiftUI
import FamilyControls
/**
 
 1. You must be able to check permission settings
 2. Schedule setting (time setting)
 3. App settings
 4. Create a monitoring schedule based on the set schedule and app settings.
 
 */

struct ScheduleView: View {
    //    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var scheduleViewModel: ScheduleViewModel
    
    /// This is a variable that will store the apps selected before pressing the save schedule button.
    @State var tempSelection = FamilyActivitySelection()
    
    var body: some View {
        NavigationView {
            VStack {
                setupListView()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar { savePlanButtonView() }
            //            .navigationTitle("Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .familyActivityPicker(
                isPresented: $scheduleViewModel.isFamilyActivitySectionActive,
                selection: $tempSelection
            )
            .alert("Saved.", isPresented: $scheduleViewModel.isSaveAlertActive) {
                Button("OK", role: .cancel) {}
            }
            .alert("When monitoring is stopped, the time and app you set will be reset.", isPresented: $scheduleViewModel.isStopMonitoringAlertActive) {
                Button("Cancel", role: .cancel) {}
                Button("Check", role: .destructive) {
                    tempSelection = FamilyActivitySelection()
                    scheduleViewModel.stopScheduleMonitoring()
                }
            }
            .alert("When permission is removed, the schedule is also removed.", isPresented: $scheduleViewModel.isRevokeAlertActive) {
                Button("Cancel", role: .cancel) {}
                Button("Check", role: .destructive) {
                    FamilyControlsManager.shared.requestAuthorizationRevoke()
                }
            }
        }
        .onAppear {
            tempSelection = scheduleViewModel.selection
        }
        //        .onChange(of: colorScheme) { _ in
        //            tempSelection = scheduleViewModel.selection
        //        }
    }
}

// MARK: - Views
extension ScheduleView {
    
    /// This is the top button on the toolbar on the right side of the schedule page.
    private func savePlanButtonView() -> ToolbarItemGroup<Button<Text>> {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            let BUTTON_LABEL = "Save Schedule"
            
            Button {
                scheduleViewModel.saveSchedule(selectedApps: tempSelection)
            } label: {
                Text(BUTTON_LABEL)
            }
        }
    }
    
    /// This is the entire list view on the schedule page.
    private func setupListView() -> some View {
        List {
            setUpTimeSectionView()
            setUPAppSectionView()
            stopScheduleMonitoringSectionView()
            revokeAuthSectionView()
        }
        .listStyle(.insetGrouped)
    }
    
    /// This view corresponds to the time settings section of the entire list.
    private func setUpTimeSectionView() -> some View {
        let TIME_LABEL_LIST = ["Start Time", "End Time"]
        let times = [$scheduleViewModel.scheduleStartTime, $scheduleViewModel.scheduleEndTime]
        
        return Section(
            header: Text(ScheduleSectionInfo.time.header),
            footer: Text(ScheduleSectionInfo.time.footer)) {
                ForEach(0..<TIME_LABEL_LIST.count, id: \.self) { index in
                    DatePicker(selection: times[index], displayedComponents: .hourAndMinute) {
                        Text(TIME_LABEL_LIST[index])
                    }
                }
            }
    }
    
    /// This view corresponds to the app settings section of the entire list.
    private func setUPAppSectionView() -> some View {
        let BUTTON_LABEL = "Change"
        let EMPTY_TEXT = "Choose Your App"
        
        return Section(
            header: HStack {
                Text(ScheduleSectionInfo.apps.header)
                Spacer()
                Button {
                    scheduleViewModel.showFamilyActivitySelection()
                } label: {
                    Text(BUTTON_LABEL)
                }
            },
            footer: Text(ScheduleSectionInfo.apps.footer)
        ) {
            if isSelectionEmpty() {
                Text(EMPTY_TEXT)
                    .foregroundColor(Color.secondary)
            } else {
                ForEach(Array(tempSelection.applicationTokens), id: \.self) { token in
                    Label(token)
                }
                ForEach(Array(tempSelection.categoryTokens), id: \.self) { token in
                    Label(token)
                }
                ForEach(Array(tempSelection.webDomainTokens), id: \.self) { token in
                    Label(token)
                }
            }
        }
    }
    
    /// This view corresponds to the schedule monitoring interruption section of the entire list.
    private func stopScheduleMonitoringSectionView() -> some View {
        Section(
            header: Text(ScheduleSectionInfo.monitoring.header)
        ) {
            stopScheduleMonitoringButtonView()
        }
    }
    
    /// This button corresponds to the button in the Stop Schedule Monitoring section.
    private func stopScheduleMonitoringButtonView() -> some View {
        let BUTTON_LABEL = "Stop monitoring schedule"
        
        return Button {
            scheduleViewModel.showStopMonitoringAlert()
        } label: {
            Text(BUTTON_LABEL)
                .tint(Color.red)
        }
    }
    
    /// This view corresponds to the permission removal section of the entire list.
    private func revokeAuthSectionView() -> some View {
        Section(
            header: Text(ScheduleSectionInfo.revoke.header)
        ) {
            revokeAuthButtonView()
        }
    }
    
    /// This button corresponds to the button in the Remove Permission section.
    /// When you click the button, you can remove Screen Time permissions through an alert window.
    private func revokeAuthButtonView() -> some View {
        let BUTTON_LABEL = "Remove Screen Time permission"
        
        return Button {
            scheduleViewModel.showRevokeAlert()
        } label: {
            Text(BUTTON_LABEL)
                .tint(Color.red)
        }
    }
    
}

// MARK: - Methods
extension ScheduleView {
    
    /// This method checks whether the app & domain token selected by the user is empty.
    private func isSelectionEmpty() -> Bool {
        tempSelection.applicationTokens.isEmpty &&
        tempSelection.categoryTokens.isEmpty &&
        tempSelection.webDomainTokens.isEmpty
    }
    
}

//struct ScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleView()
//    }
//}
