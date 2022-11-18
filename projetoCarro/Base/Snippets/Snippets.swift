//
//  Snippets.swift
//  projetoCarro
//
//  Created by Roberto Edgar Geiss on 03/11/22.
//

//import Foundation
//import CoreData
//
//func createACompany() {
//    // no appDel here. appDel and managedContext are best declared in the class scope. See gist for entire ViewController
//    guard let moc = managedContext else { return }
//
//    guard let company = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: moc) as? Company else {
//        return // guard is handy to "abort"
//    }
//    company.name = "Apple"
//
//    guard let bob = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: moc) as? Employee else {
//        return
//    }
//    bob.name = "Bob"
//    bob.company = company
//
//    do {
//        try moc.save()
//    } catch {
//        print("core data save error : \(error)")
//    }
//
//    moc.refreshAllObjects()
//
//}
//
//func fetchCompanies() -> [Company] {
//
//    guard let moc = managedContext else { return [] }
//    let request = NSFetchRequest(entityName: "Company")
//    request.returnsObjectsAsFaults = true
//
//    do {
//        let results = try moc.executeFetchRequest(request)
//
//        guard let companies = results as? [Company] else {
//            return []
//        }
//
//        return companies
//
//    }catch let error as NSError{
//        print("core data fetch error: \(error)")
//        return []
//    }
//
//}
//
//func getEmployees(forCompany company : Company) -> [Employee] {
//
//    guard let employeeSet = company.employees, let employees = employeeSet.allObjects as? [Employee] else {
//        return []
//    }
//
//    return employees
//
//}   
// https://dps923.ca/notes/core-data-multi-entities.html
// https://www.hackingwithswift.com/forums/swiftui/list-nsfetchedresultscontroller-sections/9379
// https://stackoverflow.com/questions/58574847/how-to-dynamically-create-sections-in-a-swiftui-list-foreach-and-avoid-unable-t
