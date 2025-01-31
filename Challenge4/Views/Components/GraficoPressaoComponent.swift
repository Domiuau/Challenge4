
//
//  GraficoPressaoComponent.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 30/01/25.
//

import SwiftUI
import Charts

struct GraficoPressaoComponent: View {
    
    var registrosPressoes: [PressaoEntity]
    var maior: Int
    var menor: Int
    
    init(registrosPressoes: [PressaoEntity], maior: Int, menor: Int) {
        self.registrosPressoes = registrosPressoes
        print(maior)
        print(menor)
        self.maior = maior
        self.menor = menor
    }
    
    var body: some View {
        Chart {
            ForEach(registrosPressoes) { registro in
                LineMark(
                    x: .value("", dataFormatada(data: registro.data!) + dataFormatadaHorario(data: registro.data!)),
                    y: .value("", registro.sistolica)
                )
                .foregroundStyle(Color.cinzaEscuro)
                .opacity(0.7)
                
                PointMark(
                    x: .value("", dataFormatada(data: registro.data!) + dataFormatadaHorario(data: registro.data!)),
                    y: .value("", registro.sistolica)
                )
                .foregroundStyle(Color.vinhoBotoes)
                .symbolSize(100)
                .annotation(position: .top, alignment: .center, spacing: 3) {
                    Text("\(registro.sistolica)/\(registro.diastolica)")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(Color.preto)
                        .bold()
                }
                
            }
        }
        .chartXAxis {
            
            
            
            AxisMarks() { value in
                
                AxisValueLabel(content: {
                    VStack(spacing: -2) {
                        Text(dataFormatada(data: registrosPressoes[value.index].data)).font(.footnote)
                        Text(dataFormatadaHorario(data: registrosPressoes[value.index].data))
                        
                    }.padding(0)
                })
                .font(.caption2)
                
                
                
            }
            
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        //.chartYAxis(Visibility.hidden)
        .bold()
        //  .chartXAxis(Visibility.hidden)
        // .border(Color.black, width: 2)
        .chartYScale(domain: 80...180)
        .frame(height: 260)
     
        
        
    }
    

    
    func dataFormatada(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy "
        return dateFormatter.string(from: data!)
    }
    
    func dataFormatadaHorario(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss "
        return dateFormatter.string(from: data!)
        
    }
    
    
    
    
}

struct Entidade: Identifiable {
    
    let id = UUID()
    let sistolica: Int
    let diastolica: Int
    let data: Date
    static var count: Int = 0
    
    init(sistolica: Int, diastolica: Int) {
        self.sistolica = sistolica
        self.diastolica = diastolica
        
        if let newDate = Calendar.current.date(byAdding: .day, value: Entidade.count, to: Date()) {
            
            self.data = newDate
            Entidade.count += 1
        } else {
            self.data = Date()
        }
    }
}

//#Preview {
//    GraficoPressaoComponent(registrosPressoes: [Entidade(sistolica: 125, diastolica: 42), Entidade(sistolica: 121, diastolica: 45), Entidade(sistolica: 126, diastolica: 40), Entidade(sistolica: 120, diastolica: 47), Entidade(sistolica: 128, diastolica: 40), Entidade(sistolica: 128, diastolica: 40), Entidade(sistolica: 138, diastolica: 40), Entidade(sistolica: 129, diastolica: 40)])
//}
