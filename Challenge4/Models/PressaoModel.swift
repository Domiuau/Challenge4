//
//  PressaoModel.swift
//  HearTrack
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 12/02/25.
//

import Foundation
import SwiftData

@Model
class PressaoModel {
    var id = UUID()
    var data: Date
    var diastolica: Int
    var sistolica: Int
    
    init(data: Date, diastolica: Int, sistolica: Int) {
        self.data = data
        self.diastolica = diastolica
        self.sistolica = sistolica
    }
}
