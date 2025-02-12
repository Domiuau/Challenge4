//
//  RemediosModel.swift
//  HearTrack
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 12/02/25.
//

import Foundation
import SwiftData

@Model
class RemediosModel {
    var id = UUID()
    var nomeRemedio: String
    var dosagem: String
    var horario: String
    var notifyOn: Bool
    var imagem: Data?
    
    init(nomeRemedio: String, dosagem: String, horario: String, notifyOn: Bool, imagem: Data?) {
        self.nomeRemedio = nomeRemedio
        self.dosagem = dosagem
        self.horario = horario
        self.notifyOn = notifyOn
        self.imagem = imagem
    }
}
