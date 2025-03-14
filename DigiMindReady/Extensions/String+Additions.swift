//
//  String+Additions.swift
//  GPay
//
//  Created by Md. Mehedi Hasan on 23/8/20.
//  Copyright © 2020 GrameenPhone Ltd. All rights reserved.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func trim(newLine: Bool = false) -> String {
        if newLine {
            return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        } else {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }
    
    var boolValue: Bool {
        return self.lowercased() == "yes" || self == "1" || self.lowercased() == "true"
    }
    
    func getPlural(_ yes: Bool) -> String {
        return yes ? self+"s": self
    }
    
    func getPlural(count: Int) -> String {
        return getPlural(count > 1)
    }
    
    func validateEmailStandard() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    func validateEmailBetter() -> Bool {
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: self)
    }

    ///Swift extension method to check for a valid email address (uses Apples data detector instead of a regex)
    func isValidEmail() -> Bool {
        
        guard !self.lowercased().hasPrefix("mailto:") else { return false }
        guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        let matches = emailDetector.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored,
                                            range: NSRange(location: 0, length: self.count))
        guard matches.count == 1 else { return false }
        return matches[0].url?.scheme == "mailto"
    }
    
    func validateRegex(_ regex: String?) -> Bool {
        let regexTest = NSPredicate(format: "SELF MATCHES %@", regex ?? "")
        let success: Bool = regexTest.evaluate(with: self)
        return success
    }
    
    func cleanPhoneNumber() -> String {
        var cleanNumber = ""
        //let text = self.reversed() //.flatMap({ normalizeArabicNumeralString($0, type: .western) }) {
        for c in self {
            if c >= "0" && c <= "9" {
                cleanNumber += String(c)
            }
        }
        return String(cleanNumber.suffix(11))
    }
    
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
