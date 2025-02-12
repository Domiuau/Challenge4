//
//  PressaoModel.swift
//  HearTrack
//
//  Created by AMANDA CAROLINE DA SILVA RODRIGUES on 06/02/25.
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
