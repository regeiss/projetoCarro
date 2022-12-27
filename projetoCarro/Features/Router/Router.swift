//
//  Router.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 06/08/22.
//

import Foundation
import NavigationStack
import CoreData
 
@available(iOS 16.0, *)
final class MyRouter: ObservableObject
{
    let navStack: NavigationStackCompat
    static let shared = MyRouter(navStack: ContentView.navigationStack)
    
    var isEdit: Bool = false
    
    private init(navStack: NavigationStackCompat)
    {
        self.navStack = navStack
    }

    func toMenu()
    { 
        self.navStack.pop(to: .root)
    }
    
    func toAbastecimento()
    {
        self.navStack.push(AbastecimentoView())
    }
    
    func toListaAbastecimento()
    {
        self.navStack.push(AbastecimentoListaView())
    }
    
    func toListaCarro()
    {
        self.navStack.push(CarroListaView())
    }
    
    func toServico(servico: Servico, isEdit: Bool)
    {
        self.navStack.push(ServicoView(isEdit: isEdit, servico: servico))
    }
    
     func toItemServico()
    {
        self.navStack.push(ItemServicoView())
    }
    
    func toListaServico()
    {
        self.navStack.push(ServicoListaView())
    }
    
    func toListaItemServico()
    {
        self.navStack.push(ItemServicoListaView())
    }
    
    func toListaCategoria()
    {
        self.navStack.push(CategoriaListaView())
    }
    
    func toListaPerfil()
    {
        self.navStack.push(PerfilListaView())
    }
    
    func toCarro(carro: Carro, isEdit: Bool)
    {
        self.navStack.push(CarroView(isEdit: isEdit, carro: carro))
    }
    
    func toCategoria(categoria: Categoria, isEdit: Bool)
    {
        self.navStack.push(CategoriaView(isEdit: isEdit, categoria: categoria))
    }
    
    func toRelatorios()
    {
        self.navStack.push(RelatoriosView())
    }
    
    func toAlertas()
    {
        self.navStack.push(AlertasView())
    }
    
    func toConfig()
    {
        self.navStack.push(ConfiguracaoView())
    }
    
    func toPosto(posto: Posto, isEdit: Bool)
    {
        self.navStack.push(PostoView(isEdit: isEdit, posto: posto))
    }
    
    func toListaPosto()
    {
        self.navStack.push(PostoListaView())
    }
    
    func toPerfil(perfil: Perfil, isEdit: Bool)
    {
        self.navStack.push(PerfilView(isEdit: isEdit, perfil: perfil))
    }

    func toCadastros()
    {
        self.navStack.push(CadastrosView())
    }
    
   func toGraficos()
    {
        self.navStack.push(GraficosView())
    }
    
    func toRelCombustivel()
    {
         self.navStack.push(RelCombustivelView())
    }
    
    func toRelConsumo()
    {
         self.navStack.push(RelConsumoView())
    }
    
    func toRelServico()
    {
         self.navStack.push(RelServicoView())
    }
    
    func toAlertaDetalhe()
    {
         self.navStack.push(AlertaDetalheView())
    }
    
    func toLogin()
    {
        self.navStack.push(Login())
    }
}
