//
//  AppUtility.swift
//  ScreenSafeTots
//
//  Created by Md Mehedi Hasan on 10/8/23.
//

import Foundation

struct AppUtility {
    
    static func loadJson<T: Decodable>(filename fileName: String) -> T? {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: data)
                return decodedObject
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
}



