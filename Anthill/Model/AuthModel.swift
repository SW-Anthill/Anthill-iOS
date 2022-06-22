//
//  AuthModel.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import Foundation

struct ValidResponse: Codable {
    var message: String
    
    func getResultFromMessage() -> Bool {
        return self.message == "true" ? true : false
    }
}
