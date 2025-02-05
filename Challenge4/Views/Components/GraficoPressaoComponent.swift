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
    @Binding var tipoDePressao: Int
    
    var body: some View {
        
        if !registrosPressoes.isEmpty {
            
            Chart {
                ForEach(registrosPressoes) { registro in
                    LineMark(
                        x: .value("", vm.dataFormatada(data: registro.data!) + vm.dataFormatadaHorario(data: registro.data!)),
                        y: .value("", tipoDePressao == 0 ? registro.sistolica : registro.diastolica)
                    )
                    .foregroundStyle(Color.cinzaEscuro)
                    .lineStyle(.init(lineWidth: 5))
                    .opacity(0.4)
                    
                    PointMark(
                        x: .value("", vm.dataFormatada(data: registro.data!) + vm.dataFormatadaHorario(data: registro.data!)),
                        y: .value("", tipoDePressao == 0 ? registro.sistolica : registro.diastolica)
                    )
                    .foregroundStyle(Color.vinhoBotoes)
                    .symbolSize(100)
                    .annotation(position: .top, alignment: .center, spacing: 3) {

                        
                        HStack(spacing: 1) {
                            Text(String(registro.sistolica))
                                .foregroundColor(Color.preto)
                                .font(tipoDePressao == 0 ? .title3 : .footnote)
                                .fontWeight(tipoDePressao == 0 ? .heavy : .regular)
                             //   .bold(tipoDePressao == 0)
                              //  .opacity(tipoDePressao == 0 ? 1 : 0.5)
                            Text("/").bold()
                            Text(String(registro.diastolica))
                                .font(tipoDePressao == 1 ? .title3 : .footnote)
                                .foregroundColor(Color.preto)
                                .fontWeight(tipoDePressao == 1 ? .heavy : .regular)

                              //  .opacity(tipoDePressao == 1 ? 1 : 0.5)

                                
                        }
                    }
                    
                }
            }
            .chartXAxis {
                
                AxisMarks() { value in
                    
                    AxisValueLabel(content: {
                        VStack(spacing: -2) {
                          //  Text(vm.dataFormatada(data: registrosPressoes[registrosPressoes.count - 1 - value.index].data)).font(.footnote)
                            //Text(vm.dataFormatadaHorario(data: registrosPressoes[registrosPressoes.count - 1 - value.index].data))
                            Text(vm.dataFormatada(data: registrosPressoes[value.index].data)).font(.footnote)
                            Text(vm.dataFormatadaHorario(data: registrosPressoes[value.index].data))
                            
                        }.padding(0)
                    })
                    .font(.caption2)
                    
                }
                
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 4)
            .bold()
            .chartYScale(domain: tipoDePressao == 0 ? (PressaoViewModel.MIN_SISTOLICO - 5)...(PressaoViewModel.MAX_SISTOLICO + 5) : (PressaoViewModel.MIN_DIASTOLICO - 5)...(PressaoViewModel.MAX_DIASTOLICO + 5))
            .frame(height: 260)
        } else {
            
            VStack(spacing: 10) {
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(.cinzaClaro)
                    .font(.system(size: 80))
                
                Text("Nenhuma pressão cadastrada.")
                    .multilineTextAlignment(.center)
                    .font(.title2)
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

