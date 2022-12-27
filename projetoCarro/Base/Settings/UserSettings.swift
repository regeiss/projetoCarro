//
//  UserSettings.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 09/08/22.
//

import Foundation
import Combine

class UserSettings: ObservableObject
{
    // TODO: Verificar o uso de wrapper
    @Published var perfil: String {
        didSet {
            UserDefaults.standard.set(backup, forKey: "perfil")
        }
    }
    
    @Published var idcarro: UUID {
        didSet {
            UserDefaults.standard.set(backup, forKey: "idcarro")
        }
    }
    
    @Published var backup: Bool {
        didSet {
            UserDefaults.standard.set(backup, forKey: "fazBackup")
        }
    }
    
    @Published var alertas: Bool {
        didSet {
            UserDefaults.standard.set(alertas, forKey: "usaAlertas")
        }
    }
    
    @Published var unidadeVolume: String {
        didSet {
            UserDefaults.standard.set(unidadeVolume, forKey: "unidadeVolume")
        }
    }
    
    @Published var modoEscuro: Bool {
        didSet {
            UserDefaults.standard.set(modoEscuro, forKey: "modoEscuro")
        }
    }
    public var unidadesVolume = ["lts", "gls", "m3"]
    public var contextSet: Bool {
        didSet {
            UserDefaults.standard.set(contextSet, forKey: "contextSet")
        }
    }
    
    init()
    {
        self.backup = UserDefaults.standard.object(forKey: "fazBackup") as? Bool ?? false
        self.alertas = UserDefaults.standard.object(forKey: "usaAlertas") as? Bool ?? false
        self.unidadeVolume = UserDefaults.standard.object(forKey: "unidadeVolume") as? String ?? "lts"
        self.perfil = UserDefaults.standard.object(forKey: "perfil") as? String ?? ""
        self.idcarro = UserDefaults.standard.object(forKey: "idcarro") as? UUID ?? UUID()
        self.modoEscuro = UserDefaults.standard.object(forKey: "modoEscuro") as? Bool ?? false
        self.contextSet = UserDefaults.standard.object(forKey: "contextSet") as? Bool ?? false
    }
}
