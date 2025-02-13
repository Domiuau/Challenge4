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
    var modelContextRemedios: ModelContext? = nil


    func fetchRemedios() {
            let fetchDescriptor = FetchDescriptor<RemediosModel>()
        do {
            remedios = (try (modelContextRemedios?.fetch(fetchDescriptor))) ?? []
        } catch {
            fatalError("erro em abrir container")
        }
    }
    
    func addRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data?, notifyOn: Bool) {
        let newRemedio = RemediosModel(nomeRemedio: remedioNome, dosagem: dosagem, horario: horario, notifyOn: notifyOn, imagem: imagem)
        modelContextRemedios?.insert(newRemedio)
        saveRemedios()
        
        if(notifyOn) {
            scheduleNotification(for: newRemedio)
        }
    }
    
    func updateRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data?, remedio: RemediosModel, notifyOn: Bool) {
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
        }
    }
    
    func saveRemedios() {
        do {
            try modelContextRemedios?.save()
            fetchRemedios()
            
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteRemedios(entidade: RemediosModel) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entidade.id.uuidString])
        
        modelContextRemedios?.delete(entidade)
        saveRemedios()
    }
    
    func deleteRemedio(index: IndexSet) {
        guard let index = index.first else { return }
        let remedioModel = remedios[index]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [remedioModel.id.uuidString])
        
        modelContextRemedios?.delete(remedioModel)
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
