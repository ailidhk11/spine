//
//  ViewModel.swift
//  spinev4
//
//  Created by Ailidh Kinney on 22/07/2022.
//
import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class ViewModel: ObservableObject {
    
    
    @Published var list = [SpineBook]()
    
    @Published var email = "" //Check if should be @State
    @Published var password = "" //Check if should be @State
    @Published var isUserLoggedIn = false
    
    

    init() {
        getBooks()
    }
    
 //   @Published var author = ""
   // @Published var title = ""
    //@Published var genre = ""
    
    
    func getBooks() {
        let db = Firestore.firestore()
        let ref = db.collection("SpineBooks")
        
        
        ref.getDocuments {snapshot, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
                if let snapshot = snapshot {
                    
                    
                 /*   for document in snapshot.documents {
                        let data = document.data()
                        
                        let author = data["author"] as? String ?? ""
                        let title = data["title"] as? String ?? ""
                        let genre = data["genre"] as? String ?? ""
                        
                        let book = SpineBook(id: document.documentID, author: author, genre: genre, title: title) */
                        //self.spineBooks.append(book) Unsure if this is needed for get documents
                    
                    DispatchQueue.main.async { //what does this mean apart from syncing back to UI
                        self.list = snapshot.documents.map {d in
                      
                            return SpineBook(id: d.documentID,
                                              author: d["author"] as? String ?? "",
                                              genre: d["genre"] as? String ?? "",
                                              title: d["title"] as? String ?? "")
                        }
                    }
                }

        }
    }
    



    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Incorrect info")
            }
            
        }
    }
  
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.isUserLoggedIn = false
                print(error!.localizedDescription)
                print("Sorry, those details don't look quite right, please try again!")
            } else {
                self.isUserLoggedIn = true
            }
            
            }
        }
    
        
        
    
    func signOut() {
        isUserLoggedIn.toggle()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
       print("error signing out: %@", signOutError)
    }
    }
}
