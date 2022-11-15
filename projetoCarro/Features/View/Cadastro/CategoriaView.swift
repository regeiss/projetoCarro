//
//  CategoriaView.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 29/09/22.
//

import SwiftUI
import CoreData
import NavigationStack
import FormValidator
import PhotosUI

enum CategoriaFocusable: Hashable
{
    case nome
    case icone
}

class CategoriaFormInfo: ObservableObject
{
    @Published var nome: String = ""
    @Published var icone: Image = Image(systemName: "gearshape")
    
    let regexNumerico: String =  "[0-9[\\b]]+"
    
    lazy var form = { FormValidation(validationType: .immediate)}()
    lazy var valNomeVazio: ValidationContainer = { $nome.nonEmptyValidator(form: form, errorMessage: "nome deve ser informado")}()
}

@available(iOS 16.0, *)
struct CategoriaView: View
{
    @StateObject private var viewModel = CategoriaViewModel()
    @ObservedObject var formInfo = CategoriaFormInfo()
    @FocusState private var categoriaInFocus: CategoriaFocusable?
    @State var isSaveDisabled: Bool = true
    // controle do tipo de edição
    var isEdit: Bool
    var categoria: Categoria
    // imagens
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    let router = MyRouter.shared
    let pub = NotificationCenter.default.publisher(for: Notification.Name("Save"))
    
    var body: some View
    {
        VStack
        {
            HeaderSaveView(isSaveDisabled: $isSaveDisabled, nomeView: "Categoria", nomeMenu: "Menu", destRouter: "lstCategoria")
            Form
            {
                Section()
                {
                    TextField("nome", text: $formInfo.nome)
                        .validation(formInfo.valNomeVazio)
                        .focused($categoriaInFocus, equals: .nome)
                        .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {self.categoriaInFocus = .nome}}
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Text("Selecione uma imagem")
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                // Retrieve selected asset in the form of Data
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                    
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData)
                    {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    }
                }
            }.onReceive(pub)  {_ in gravarCategoria()}
             .onAppear() {if isEdit {formInfo.nome = categoria.nome ?? ""}}
        }.onReceive(formInfo.form.$allValid) { isValid in self.isSaveDisabled = !isValid}
    }
    
    private func gravarCategoria()
    {
        let valid = formInfo.form.triggerValidation()
        if valid
        {
            if isEdit
            {
                categoria.nome = formInfo.nome
                viewModel.update(categoria: categoria)
            }
            else 
            {
                let categoria = NovaCategoria(id: UUID(),
                                            nome: formInfo.nome,
                                            icone: selectedImageData!)
            
                viewModel.add(categoria: categoria)
            }
        }
    }
}
