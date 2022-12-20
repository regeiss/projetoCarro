//
//  CategoriaListaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/09/22.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct CategoriaListaView: View
{
    @StateObject private var viewModel = CategoriaViewModel()
    let router = MyRouter.shared
    
    var body: some View
    {
        VStack
        {
            HeaderAddView(nomeView: "Lista categoria", nomeMenu: "Menu", destRouter: "cate", backRouter: "cadastros")
            List
            {
                ForEach(viewModel.categoriasLista, id: \.self) { categoria in
                    HStack
                    {
                        Text(String(categoria.nome!))
                        Spacer()
                        Image(systemName: "engine.combustion")
                    }.padding([.top, .bottom], 4)
                     .onTapGesture { editCategorias(categoria: categoria)}
                }.onDelete(perform: deleteCategorias)
            }
            Spacer()
        }
    }
    
    func editCategorias(categoria: Categoria)
    {
        router.toCategoria(categoria: categoria, isEdit: true)
    }
    
    func deleteCategorias(at offsets: IndexSet)
    {
        for offset in offsets
        {
            let categoria = viewModel.categoriasLista[offset]
            viewModel.delete(categoria: categoria)
        }
    }
}
