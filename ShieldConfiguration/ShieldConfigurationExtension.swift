//
//  ShieldConfigurationExtension.swift
//  ShieldConfiguration
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

/*
// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        ShieldConfiguration()
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}*/


// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
// MARK: - ShieldView 커스터마이징
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    // MARK: - 제한 중인 앱/도메인 웹 정보를 받아 ShieldView를 커스터마이징하는 메서드
    /// 앱/도메인 웹 사용 제한 중일 경우 overlay되는 ShieldView는 ShieldConfiguration를 통해 커스터마이징 할 수 있습니다.
    /// 각 configuration 메서드로부터 전달받은 앱 정보를 통해 커스터마이징 해보세요.
    ///  * ShieldConfiguration init 이외에 ShieldView의 커스터마이징은 제한됩니다.
    ///  * 더 많은 정보는 아래 링크를 확인하세요.
    ///  https://developer.apple.com/documentation/managedsettingsui/shieldconfiguration
    private func setShieldConfig(
        _ tokenName: String,
        hasSecondaryButton: Bool = false) -> ShieldConfiguration {
            let CUSTOM_ICON = UIImage(named: "AppLogo.pdf")
        let CUSTOM_TITLE = ShieldConfiguration.Label(
            text: "Screen Safe Future",
            color: UIColor(red: 0.00, green: 0.04, blue: 0.24, alpha: 1.00)
        )
        let CUSTOM_SUBTITLE = ShieldConfiguration.Label(
            text: "\(tokenName)'s use has been restricted.",
            color: .black
        )
        let CUSTOM_PRIMARY_BUTTON_LABEL = ShieldConfiguration.Label(
            text: "Exit",
            color: .white
        )
        let CUSTOM_PRIAMRY_BUTTON_BACKGROUND: UIColor = UIColor(red: 0.00, green: 0.04, blue: 0.24, alpha: 1.00)
        let CUSTOM_SECONDARY_BUTTON_LABEL = ShieldConfiguration.Label(
            text: "No effect when pressed",
            color: UIColor(red: 0.00, green: 0.04, blue: 0.24, alpha: 1.00)
        )
        
        let ONE_BUTTON_SHIELD_CONFIG = ShieldConfiguration(
            backgroundBlurStyle: .systemChromeMaterialLight,
            backgroundColor: .white,
            icon: CUSTOM_ICON,
            title: CUSTOM_TITLE,
            subtitle: CUSTOM_SUBTITLE,
            primaryButtonLabel: CUSTOM_PRIMARY_BUTTON_LABEL,
            primaryButtonBackgroundColor: CUSTOM_PRIAMRY_BUTTON_BACKGROUND
        )
        
        let TWO_BUTTON_SHIELD_CONFIG = ShieldConfiguration(
            backgroundBlurStyle: .systemChromeMaterialLight,
            backgroundColor: .white,
            icon: CUSTOM_ICON,
            title: CUSTOM_TITLE,
            subtitle: CUSTOM_SUBTITLE,
            primaryButtonLabel: CUSTOM_PRIMARY_BUTTON_LABEL,
            primaryButtonBackgroundColor: CUSTOM_PRIAMRY_BUTTON_BACKGROUND,
            secondaryButtonLabel: CUSTOM_SECONDARY_BUTTON_LABEL
        )
        
        return hasSecondaryButton ? TWO_BUTTON_SHIELD_CONFIG : ONE_BUTTON_SHIELD_CONFIG
    }
    
    
    // MARK: - 어플리케이션만 제한된 앱
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        guard let displayName = application.localizedDisplayName else {
            return setShieldConfig("Unverified app")
        }
        return setShieldConfig(displayName)
    }
    
    
    // MARK: - 카테고리를 통해 어플리케이션이 제한된 앱
    override func configuration(
        shielding application: Application,
        in category: ActivityCategory) -> ShieldConfiguration {
            // Customize the shield as needed for applications shielded because of their category.
        guard let displayName = application.localizedDisplayName,
              let categoryName = category.localizedDisplayName else {
            return setShieldConfig("Unverified app")
        }
        return setShieldConfig(categoryName + " " + displayName, hasSecondaryButton: true)
    }
    
    
    // MARK: - 웹 도메인만 제한된 앱
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        guard let displayName = webDomain.domain else {
            return setShieldConfig("Unverifiable web domain")
        }
        return setShieldConfig(displayName)
    }
    
    
    // MARK: - 카테고리를 통해 웹 도메인이 제한된 앱
    override func configuration(
        shielding webDomain: WebDomain,
        in category: ActivityCategory) -> ShieldConfiguration {
            // Customize the shield as needed for web domains shielded because of their category.
        guard let displayName = webDomain.domain,
              let categoryName = category.localizedDisplayName else {
            return setShieldConfig("Unverifiable web domain")
        }
        return setShieldConfig(categoryName + " " + displayName)
    }
}


