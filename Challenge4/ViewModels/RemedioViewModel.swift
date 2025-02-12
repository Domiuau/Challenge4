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
import UserNotifications
import PhotosUI

class RemedioViewModel: ObservableObject {
    @Published var remedios: [RemediosModel] = []
    var modelContext: ModelContext? = nil


    func fetchRemedios() {
            let fetchDescriptor = FetchDescriptor<RemediosModel> ()
            remedios = (try! (modelContext?.fetch(fetchDescriptor))) ?? []
    }
    
    func addRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data, notifyOn: Bool) {
        let newRemedio = RemediosModel(nomeRemedio: remedioNome, dosagem: dosagem, horario: horario, notifyOn: notifyOn, imagem: imagem)
        modelContext?.insert(newRemedio)
        saveRemedios()
        
        if(notifyOn) {
            scheduleNotification(for: newRemedio)
        }
    }
    
    func updateRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data, remedio: RemediosModel, notifyOn: Bool) {
        remedio.nomeRemedio = remedioNome
        remedio.dosagem = dosagem
        remedio.horario = horario
        remedio.imagem = imagem
        remedio.notifyOn = notifyOn
        saveRemedios()
        
        if (notifyOn) {
            scheduleNotification(for: remedio)
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [remedio.id.uuidString])
            print("bye bye not not")
        }
    }
    
    func saveRemedios() {
        do {
            try modelContext?.save()
            fetchRemedios()
            
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteRemedios(entidade: RemediosModel) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entidade.id.uuidString])
        
        modelContext?.delete(entidade)
        saveRemedios()
    }
    
    func deleteRemedio(index: IndexSet) {
        guard let index = index.first else { return }
        let remedioModel = remedios[index]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [remedioModel.id.uuidString])
        
        modelContext?.delete(remedioModel)
        saveRemedios()
    }
    
    func scheduleNotification(for remedio: RemediosModel) {
        let content = UNMutableNotificationContent()
        content.title = "Hora do Remédio 💊"
        content.body = "Está na hora de tomar \(remedio.nomeRemedio)!"
        content.sound = .default
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        if let remedioHorario = timeFormatter.date(from: remedio.horario),
           let calendarComponents = Calendar.current.dateComponents([.hour, .minute], from: remedioHorario) as DateComponents? {
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: calendarComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: remedio.id.uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Erro ao agendar notificação: \(error.localizedDescription)")
                } else {
                    print("Notificação agendada para \(remedio.horario)")
                }
            }
        }
    }
    
}
