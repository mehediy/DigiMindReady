//
//  FamilyControlManager.swift


import Foundation
import FamilyControls

class FamilyControlsManager: ObservableObject {
    static let shared = FamilyControlsManager()
    private init() {}
    
    // MARK: - FamilyControls Object that manages permission state
    let authorizationCenter = AuthorizationCenter.shared
    
    // MARK: - ScreenTime Member variables to utilize permission status
    @Published var hasScreenTimePermission: Bool = false
    
    // MARK: - ScreenTime API Request permission
    /// To use the ScreenTime API, you must first request permission.
    /// That method changes the state of the ScreenTime API permission and hasScreenTimePermission member variables.
    @MainActor
    func requestAuthorization() {
        if authorizationCenter.authorizationStatus == .approved {
            print("ScreenTime Permission approved")
        } else {
            Task {
                do {
                    try await authorizationCenter.requestAuthorization(for: .individual)
                    hasScreenTimePermission = true
                    // Agree
                } catch {
                    // agree
                    print("Failed to enroll DigiMindReady with error: \(error)")
                    hasScreenTimePermission = false
                    // User not allowed.
                    // Error Domain=FamilyControls.FamilyControlsError Code=5 "(null)
                }
            }
        }
    }
    
    // MARK: - Screen Time Permission Check
    /// When calling the method, you can check the permission status of the current ScreenTime API.
    func requestAuthorizationStatus() -> AuthorizationStatus {
        authorizationCenter.authorizationStatus
    }

    // MARK: ScreenTime revoke permission
    /// When calling the method when the permission status is .approve
    /// Change ScreenTIme permission status to .notDetermined.
    func requestAuthorizationRevoke() {
        authorizationCenter.revokeAuthorization(completionHandler: { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let failure):
                print("\(failure) - failed revoke Permission")
            }
        })
    }
    
    // MARK: - Update permission status
    /// hasScreenTimePermission This is a method to change the state of .
    func updateAuthorizationStatus(authStatus: AuthorizationStatus) {
        switch authStatus {
        case .notDetermined:
            hasScreenTimePermission = false
        case .denied:
            hasScreenTimePermission = false
        case .approved:
            hasScreenTimePermission = true
        @unknown default:
            fatalError("There is no processing for the requested permission setting type.")
        }
    }
}
