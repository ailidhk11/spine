//
//  ViewModel.swift
//  spinev4
//
//  Created by Ailidh Kinney on 22/07/2022.
//
import Foundation
import Firebase
import FirebaseFirestore

class ViewModel: ObservableObject {
    
    
    @Published var spineBooks: [SpineBook] = []
    

    
    @Published var author = ""
    @Published var title = ""
    @Published var genre = ""
    
    
    func getdata() {
        let db = Firestore.firestore()
        let ref = db.collection("SpineBooks")
        
        
        ref.getDocuments {snapshot, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
                if let snapshot = snapshot {
                    DispatchQueue.main.async { //what does this mean apart from syncing back to UI
                        self.spineBooks = snapshot.documents.map {d in

                            return SpineBook(id: d.documentID,
                                              author: d["Author"] as? String ?? "",
                                              genre: d["Genre"] as? String ?? "",
                                              title: d["Title"] as? String ?? "")
                        }
                    }
                }

        }
    }
    
    @Published private var email = "" //Check if should be @State
    @Published private var password = "" //Check if should be @State
    @Published private var isUserLoggedIn = false
    
    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Incorrect info")
            }
            
        }
    }
  
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.isUserLoggedIn = false
                print(error!.localizedDescription)
                print("Sorry, those details don't look quite right, please try again!")
            }
        }
    }
}
