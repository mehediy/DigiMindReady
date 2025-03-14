//
//  UserDefaultsStore.swift
//
//  Created by Md. Mehedi Hasan on 22/9/20.


import Foundation
import UIKit

/// This enum contains access to all `UserDefaults` stored in this app.
/// The string associated with each case is the key name for accessing value inside `UserDefaults`.
///
enum UserDefaultsStore<T:Codable> {
    case notificationID(String)
    case testEnvironment
    case profileQuizSurveryEvent

    var key: String {
        switch self {
        case .notificationID(let msisdn): return "notificationID_\(msisdn)"
        case .testEnvironment: return "AppTestEnvironment"
        case .profileQuizSurveryEvent: return "ProfileQuizSurveryEvent"

        }
    }
    
}

extension UserDefaultsStore {
    
    /// Used for setting or getting value from `UserDefaults`
    
    var value: T? {
        get {
            guard validateExpiration() else { return nil }
            return UserDefaults.standard.object(forKey: self.key) as? T
        }
        
        nonmutating set {
            
            guard let value = newValue else{
                UserDefaults.standard.removeObject(forKey: self.key)
                return
            }
            
            UserDefaults.standard.set(value, forKey: self.key)
        }
    }
    
    var objectValue: T? {
        get {
            guard validateExpiration() else { return nil }
            guard let data = UserDefaults.standard.data(forKey: self.key) else { return nil }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                return nil
            }
        }
        
        nonmutating set {
            
            guard let value = newValue else{
                UserDefaults.standard.removeObject(forKey: self.key)
                return
            }
            
            let data = try? JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: self.key)
            
        }
    }
    
    var arrayValue: [T]? {
        get {
            guard validateExpiration() else { return nil }
            guard let data = UserDefaults.standard.data(forKey: self.key) else { return [] }
            
            do {
                return try JSONDecoder().decode([T].self, from: data)
            } catch {
                return []
            }
        }
        
        nonmutating set {
            guard let value = newValue else{
                UserDefaults.standard.removeObject(forKey: self.key)
                return
            }
            let arrayData = try! JSONEncoder().encode(value)
            UserDefaults.standard.set(arrayData, forKey: self.key)
        }
    }
    
    var stringValue: String? {
        get {
            guard validateExpiration() else { return nil }
            guard let data = UserDefaults.standard.value(forKey: self.key) as? String else { return nil }
            return data
        }
        
        nonmutating set {
            if let value = newValue{
                UserDefaults.standard.set(value, forKey: self.key)
            } else {
                UserDefaults.standard.removeObject(forKey: self.key)
            }
            
        }
    }
    
    var intValue: Int? {
        get {
            guard validateExpiration() else { return nil }
            guard let data = UserDefaults.standard.value(forKey: self.key) as? Int else { return nil }
            return data
        }
        
        nonmutating set {
            if let value = newValue{
                UserDefaults.standard.set(value, forKey: self.key)
            } else {
                UserDefaults.standard.removeObject(forKey: self.key)
            }
        }
    }
    
    var boolValue: Bool? {
        get {
            guard validateExpiration() else { return nil }
            guard let data = UserDefaults.standard.value(forKey: self.key) as? Bool else { return nil }
            return data
        }
        
        nonmutating set {
            if let value = newValue{
                UserDefaults.standard.set(value, forKey: self.key)
            } else {
                UserDefaults.standard.removeObject(forKey: self.key)
            }
            
        }
    }
}


extension UserDefaultsStore {
    
    var expireKey: String { return "\(self.key)-expire" }
    
    var expireValue: Date? {
        get {
            return UserDefaults.standard.object(forKey: self.expireKey) as? Date
        }
        
        nonmutating set {
            UserDefaults.standard.set(newValue, forKey: self.expireKey)
        }
    }
    
    @discardableResult
    func validateExpiration() -> Bool {
        guard let expire = self.expireValue else {
            return true
        }
        
        guard expire < Date() else {
            UserDefaults.standard.set(nil, forKey: self.key)
            UserDefaults.standard.set(nil, forKey: self.expireKey)
            return false
        }
        return true
    }
}

enum UserDefaultsImageStore {
    
    case userImage(msisdn: String)
    
    var key: String {
        switch self {
        case .userImage(let msisdn) : return "user_image_\(msisdn)"
        }
    }
    
    var imageValue: UIImage? {
        get {
            var image: UIImage?
            if let imageData = UserDefaults.standard.data(forKey: self.key) {
                image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
            }
            return image
        }
        
        nonmutating set {
            var imageData: NSData?
            if let image = newValue {
                imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
            }
            UserDefaults.standard.set(imageData, forKey: self.key)
        }
    }
}

