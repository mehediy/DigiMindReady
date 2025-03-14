//
//  AdvocatorViewModel.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 3/18/24.
//

import Foundation

class AdvocatorViewModel: ObservableObject {
    
//    @Published private(set) var advocators: [School] = []
    @Published private(set) var isLoading: Bool = false
    
    func fetchSchools() {
        
//        guard schools.isEmpty else { return }
        
        isLoading = true
        
//        CommonService.fetchNYCSchools { [weak self] schools, err in
//            
//            guard let self = self else { return }
//            
//            self.isLoading = false
//            
//            if let error = err {
//                print(error)
//            } else {
//                self.schools = schools
//                print(schools.count)
//            }
//        }
    }
    
    
}
