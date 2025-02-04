/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI
import Charts

struct GraficoPressaoComponent: View {
    @ObservedObject var vm = PressaoViewModel()
    var registrosPressoes: [PressaoEntity]
    
    var body: some View {
        
        if !registrosPressoes.isEmpty {
            
            Chart {
                ForEach(registrosPressoes.reversed()) { registro in
                    LineMark(
                        x: .value("", vm.dataFormatada(data: registro.data!) + vm.dataFormatadaHorario(data: registro.data!)),
                        y: .value("", registro.sistolica)
                    )
                    .foregroundStyle(Color.cinzaEscuro)
                    .lineStyle(.init(lineWidth: 5))
                    .opacity(0.4)
                    
                    PointMark(
                        x: .value("", vm.dataFormatada(data: registro.data!) + vm.dataFormatadaHorario(data: registro.data!)),
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
                            Text(vm.dataFormatada(data: registrosPressoes[registrosPressoes.count - 1 - value.index].data)).font(.footnote)
                            Text(vm.dataFormatadaHorario(data: registrosPressoes[registrosPressoes.count - 1 - value.index].data))
                            
                        }.padding(0)
                    })
                    .font(.caption2)
                    
                }
                
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 4)
            .bold()
            .chartYScale(domain: 70...180)
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

