//
//  HeaderFiltroView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 02/10/22.
//
import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct HeaderFiltroView: View
{
    var nomeView: String
    var nomeMenu: String
    var destRouter: String
    @State var filtroPeriodo:[String: String] = ["Periodo": ""]
    @State private var isShowingSheet = false

    let router = MyRouter.shared
    let savePublisher = NotificationCenter.default.publisher(for: NSNotification.Name("Filtro"))
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.leading])
                    .onTapGesture
                {
                    switch destRouter
                    {
                        case "rel":
                            router.toRelatorios()
                        default:
                            router.toMenu()
                    }
                }
                
                Text(nomeMenu).foregroundColor(.blue).font(.system(.title3, design: .rounded))
                Spacer()
                
                Menu
                {
                    Button("Mês atual", action: { filtroPeriodo["Periodo"] = "Mês atual"; NotificationCenter.default.post(name: NSNotification.Name("Filtro"), object: nil, userInfo: filtroPeriodo)})
                    Button("Selecionar", action: { isShowingSheet = true; filtroPeriodo["Periodo"] = "Selecionar"; NotificationCenter.default.post(name: NSNotification.Name("Filtro"), object: nil, userInfo: filtroPeriodo)})
                    Button("Últimos 15 dias", action: { filtroPeriodo["Periodo"] = "Últimos 15 dias"; NotificationCenter.default.post(name: NSNotification.Name("Filtro"), object: nil, userInfo: filtroPeriodo)})
                    Button("Últimos 30 dias", action: { filtroPeriodo["Periodo"] = "Últimos 30 dias"; NotificationCenter.default.post(name: NSNotification.Name("Filtro"), object: nil, userInfo: filtroPeriodo)})
                    Button("Limpar seleção", action: { filtroPeriodo["Periodo"] = "Limpar"; NotificationCenter.default.post(name: NSNotification.Name("Filtro"), object: nil, userInfo: filtroPeriodo)})
                } label: { Label("", systemImage: "line.3.horizontal.decrease.circle").foregroundColor(.blue).imageScale(.large)}
            }.padding([.trailing])
        }.sheet(isPresented: $isShowingSheet)
            {
                SelecaoDataView(isShowingSheet: $isShowingSheet)
            }
        
        HStack()
        {
            Text(nomeView).font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .padding([.leading])
            Spacer()
        }.padding([.top])
    }
}

struct SelecaoDataView: View 
{
    @Environment(\.dismiss) var dismiss
    @Environment(\.calendar) var calendar
    @Binding var isShowingSheet: Bool
    @State var dates: Set<DateComponents> = []

    var body: some View
    {
        VStack
        {
            MultiDatePicker("Selecione as datas", selection: $dates)

            Text(summary)
            Button("OK", action: { isShowingSheet.toggle() }).buttonStyle(.bordered)
            Spacer()
        }
        .presentationDetents([.medium, .large])
        .padding()
    }

    var summary: String
    {
        dates.compactMap { components in
            calendar.date(from: components)?.formatted(date: .long, time: .omitted)
        }.formatted()
    }
    // TODO: Ver porque nao passa aqui no dismiss da sheet
    func didDismiss()
    {
        print(summary)
    }
}
