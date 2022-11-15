//
//  Keychain.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 26/10/22.
//

import Foundation
import AuthenticationServices

func save(_ data: Data, service: String, account: String)
{
    let query = [
        kSecValueData: data,
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
        
    let saveStatus = SecItemAdd(query, nil)
 
    if saveStatus != errSecSuccess {
        print("Error: \(saveStatus)")
    }
    
    if saveStatus == errSecDuplicateItem {
        update(data, service: service, account: account)
    }
}

func update(_ data: Data, service: String, account: String)
{
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
        
    let updatedData = [kSecValueData: data] as CFDictionary
    SecItemUpdate(query, updatedData)
}

func read(service: String, account: String) -> Data?
{
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecReturnData: true
    ] as CFDictionary
        
    var result: AnyObject?
    SecItemCopyMatching(query, &result)
    return result as? Data
}

func delete(service: String, account: String)
{
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
        
    SecItemDelete(query)
}

