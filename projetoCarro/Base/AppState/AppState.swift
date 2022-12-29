//
//  AppState.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 27/12/22.
//

import Foundation
import SwiftUI

class AppState
{
    var ultimaKM: Int32
    var carroAtual: Carro?
    var carroPadrao: Carro?
    var perfilAtual: Perfil?
    var perfilPadrao: Perfil?
    var postoPadrao: Posto?
    
    static var shared = AppState()
    
    private init()
    {
        ultimaKM = 1
    }
}
