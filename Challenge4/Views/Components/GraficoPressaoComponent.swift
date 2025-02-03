
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
    
    init(registrosPressoes: [PressaoEntity]) {
        self.registrosPressoes = registrosPressoes

    }
    
    var body: some View {
        
        if !registrosPressoes.isEmpty {
            
            Chart {
                ForEach(registrosPressoes.reversed()) { registro in
                    LineMark(
                        x: .value("", dataFormatada(data: registro.data!) + dataFormatadaHorario(data: registro.data!)),
                        y: .value("", registro.sistolica)
                    )
                    .foregroundStyle(Color.cinzaEscuro)
                    .lineStyle(.init(lineWidth: 5))
                    .opacity(0.4)
                    
                    PointMark(
                        x: .value("", dataFormatada(data: registro.data!) + dataFormatadaHorario(data: registro.data!)),
                        y: .value("", registro.sistolica)
                    )
                    .foregroundStyle(Color.vinhoBotoes)
                    .symbolSize(100)
                    .annotation(position: .top, alignment: .center, spacing: 3) {
                        Text("\(registro.sistolica)/\(registro.diastolica)")
                            .font(.footnote)
                            .foregroundColor(Color.preto)
                            .bold()
                    }
                    
                }
            }
            .chartXAxis {
                
                
                
                AxisMarks() { value in
                    
                    AxisValueLabel(content: {
                        VStack(spacing: -2) {
                            Text(dataFormatada(data: registrosPressoes[registrosPressoes.count - 1 - value.index].data)).font(.footnote)
                            Text(dataFormatadaHorario(data: registrosPressoes[registrosPressoes.count - 1 - value.index].data))
                            
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
        } else {
            
            VStack(spacing: 10) {
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(.cinzaClaro)
                    .font(.system(size: 80))
                
                Text("Nenhuma pressão cadastrada.")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(.cinzaClaro)
                
            }
            .frame(height: 260)
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    func dataFormatada(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy "
        return dateFormatter.string(from: data!)
    }
    
    func dataFormatadaHorario(data: Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss "
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
