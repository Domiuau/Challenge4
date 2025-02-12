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
import SwiftUI

class RemedioViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Query var entidadeSalvasRemedio: [RemediosModel]
    
    func addRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data, notifyOn: Bool) {
        let newRemedio = RemediosModel(nomeRemedio: remedioNome, dosagem: dosagem, horario: horario, notifyOn: notifyOn, imagem: imagem)
      
        saveRemedios()
        
        if(notifyOn) {
            scheduleNotification(for: newRemedio)
        }
    }
    
    
    func updateRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data, entidade: RemediosModel, notifyOn: Bool) {
        entidade.nomeRemedio = remedioNome
        entidade.dosagem = dosagem
        entidade.horario = horario
        entidade.imagem = imagem
        entidade.notifyOn = notifyOn
        saveRemedios()
        
        if (notifyOn) {
            scheduleNotification(for: entidade)
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entidade.id.uuidString])
            print("bye bye not not")
        }
    }
    
    func saveRemedios() {
        do {
                try modelContext.save()
            } catch {
                print("Erro ao salvar: \(error.localizedDescription)")
            }
    }
    
    func deleteRemedios(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = entidadeSalvasRemedio[index]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entity.id.uuidString])
        
        modelContext.delete(entity)
        saveRemedios()
    }
    
    func deleteRemedio(entidade: RemediosModel) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entidade.id.uuidString])
        
        modelContext.delete(entidade)
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
