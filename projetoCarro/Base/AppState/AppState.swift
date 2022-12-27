//
//  AppState.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/12/22.
//

import Foundation
import SwiftUI

class ModeloGlobal: ObservableObject
{
    @Published var ultimaKM: Int32 = 1
    @Published var carroAtual: Carro?
    @Published var perfilAtual: Perfil?
    @Published var perfilPadrao: Perfil?
    @Published var postoPadrao: Posto?
}
