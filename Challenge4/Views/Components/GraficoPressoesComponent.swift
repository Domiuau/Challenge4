//
//  GraficoPressoesComponent.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 30/01/25.
//

import SwiftUI
import Charts

struct GraficoPressoesComponent: View {
    
    @State var pressaoEntidades: [Entidade]
    
    var body: some View {
        Text("Hello, World!")
        
        Chart {
            ForEach (pressaoEntidades) {
                entidade in
                LineMark(x: .value("", entidade.diastolica),
                        y: .value("", entidade.sistolica))
                .foregroundStyle(Color.blue)
                .annotation(position: .top, alignment: .center, spacing: CGFloat(5), content: {
                    Text(String(dataFormatada(data: entidade.data)))
                        .font(.caption)
                        .foregroundColor(Color.yellow)
                })
            //    .clipShape(RoundedRectangle(cornerRadius: 16))
                .lineStyle(StrokeStyle(lineWidth: 3))
                .symbol(.circle)
                .symbolSize(100)
                
                
            }
            
            
        }
        .chartLegend(position: .bottom, alignment: .top, spacing: 16)
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 6)
        .padding(.vertical)
        .frame(height: 230)
    }
        
    func dataFormatada(data: Date?) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dataFormatter.string(from: data!)
    }
        
    }




struct Entidade: Identifiable {
    
    let id = UUID()
    let data = Date()
    let sistolica: String
    let diastolica: String
    
}

#Preview {
    GraficoPressoesComponent(pressaoEntidades: [Entidade(sistolica: "120", diastolica: "80"), Entidade(sistolica: "144", diastolica: "91"), Entidade(sistolica: "144", diastolica: "93"), Entidade(sistolica: "122", diastolica: "100"),Entidade(sistolica: "144", diastolica: "90"),Entidade(sistolica: "134", diastolica: "94")])
}
