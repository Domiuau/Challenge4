/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

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
