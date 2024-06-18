//
//  Grads.swift
//  GPACalculator
//
//  Created by Mehmet Alp Sönmez on 18/06/2024.
//

import Foundation
import SwiftData

@Model
class Grade {
    var name: String
    var credit: Int
    var result: Double
    
    init(name: String, credit: Int, result: Double) {
        self.name = name
        self.credit = credit
        self.result = result
    }
}
