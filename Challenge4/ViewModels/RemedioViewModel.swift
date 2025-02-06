/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import Foundation
import CoreData
import UserNotifications
import PhotosUI

class RemedioViewModel: ObservableObject {
    private let conteudo = PersistenceController.persistencia.container.viewContext
    @Published var entidadeSalvasRemedio: [RemedioEntity] = []
    
    func fetchRemedios() {
        let request = NSFetchRequest<RemedioEntity>(entityName: "RemedioEntity")
        
        do {
            entidadeSalvasRemedio = try conteudo.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data, notifyOn: Bool) {
        let newRemedio = RemedioEntity(context: conteudo)
        
        newRemedio.nomeRemedio = remedioNome
        newRemedio.dosagem = dosagem
        newRemedio.horario = horario
        newRemedio.imagem = imagem
        newRemedio.notifyOn = notifyOn
        
        saveRemedios()
        
        if(notifyOn) {
            scheduleNotification(for: newRemedio)
        }
    }
    
    
    func updateRemedio(remedioNome: String, dosagem: String, horario: String, imagem: Data, entidade: RemedioEntity, notifyOn: Bool) {
        entidade.nomeRemedio = remedioNome
        entidade.dosagem = dosagem
        entidade.horario = horario
        entidade.imagem = imagem
        entidade.notifyOn = notifyOn
        saveRemedios()
        
        if (notifyOn) {
            scheduleNotification(for: entidade)
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entidade.objectID.uriRepresentation().absoluteString])
            print("bye bye not not")
        }
    }
    
    func saveRemedios() {
        do {
            try conteudo.save()
            print("salvo")
            fetchRemedios()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func deleteRemedios(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = entidadeSalvasRemedio[index]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entity.objectID.uriRepresentation().absoluteString])
        
        conteudo.delete(entity)
        saveRemedios()
    }
    
    func deleteRemedio(entidade: RemedioEntity) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [entidade.objectID.uriRepresentation().absoluteString])
        
        conteudo.delete(entidade)
        saveRemedios()
    }
    
    func scheduleNotification(for remedio: RemedioEntity) {
        let content = UNMutableNotificationContent()
        content.title = "Hora do Remédio 💊"
        content.body = "Está na hora de tomar \(remedio.nomeRemedio ?? "seu remédio")!"
        content.sound = .default
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        if let remedioHorario = timeFormatter.date(from: remedio.horario ?? ""),
           let calendarComponents = Calendar.current.dateComponents([.hour, .minute], from: remedioHorario) as DateComponents? {
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: calendarComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: remedio.objectID.uriRepresentation().absoluteString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Erro ao agendar notificação: \(error.localizedDescription)")
                } else {
                    print("Notificação agendada para \(remedio.horario ?? "horário desconhecido")")
                }
            }
        }
    }
    
}
