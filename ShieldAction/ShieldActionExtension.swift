//
//  ShieldActionExtension.swift
//  ShieldAction
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import ManagedSettings

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.

// MARK: - ShieldAction
/// When accessing the app/web domain set with FamilyActivitySelection during the set schedule time
/// You can write actions on button click in Block View that restricts its use.
class ShieldActionExtension: ShieldActionDelegate {
    
    // MARK: ApplicationToken, Set the action when clicking a button in the app set with ApplicationToken.
    /// ShieldAction, the argument of the handle method, is divided into two cases.
    /// - .primaryButtonPressed: Corresponds to primaryButtonLabel in ShieldConfiguration.
    /// - .secondaryButtonPressed: Corresponds to secondaryButtonLabel in ShieldConfiguration.
    /// * If you do not differentiate or use cases, you can make it work when all buttons are clicked.
    /// * If there is no secondaryButtonLabel set to ShieldConfiguration, the case cannot be used.
    override func handle(
        action: ShieldAction,
        for application: ApplicationToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            // Handle the action as needed.
            switch action {
            case .primaryButtonPressed:
                /// Causes the system to close the current application or web browser.
                completionHandler(.close)
            case .secondaryButtonPressed:
                /// Delays response to action and updates view.
                completionHandler(.defer)
            @unknown default:
                fatalError()
            }
        }
    
    
    
    // MARK: WebDomainToken - Set the action when clicking a button on the web set to WebDomainToken.
    override func handle(
        action: ShieldAction,
        for webDomain: WebDomainToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            // Handle the action as needed.
            completionHandler(.close)
        }
    
    
    
    // MARK: ActivityCategoryToken - Set the action when clicking a button on the web set to ActivityCategoryToken.
    /// ActivityCategory is a top category group in which each application is classified based on App Category.
    /// When setting all applications within ActivityCategory, the system recognizes that it has been set to ActivityCategory.
    override func handle(
        action: ShieldAction,
        for category: ActivityCategoryToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            switch action {
            case .primaryButtonPressed:
                /// Causes the system to close the current application or web browser.
                completionHandler(.close)
            case .secondaryButtonPressed:
                /// No additional action, no updates to the view.
                completionHandler(.none)
            @unknown default:
                fatalError()
            }
        }
}
