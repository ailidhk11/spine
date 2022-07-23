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
    
    
    @Published var list = [SpineBooks]()
    

    
    @Published var Author = ""
    @Published var Title = ""
    @Published var Genre = ""
    
    
    func getdata() {
        let db = Firestore.firestore()
        
        
        db.collection("spineBooks").getDocuments {snapshot, error in
            
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map {d in

                            return SpineBooks(id: d.documentID,
                                              Author: d["Author"] as? String ?? "",
                                              Genre: d["Genre"] as? String ?? "",
                                              Title: d["Title"] as? String ?? "")
                        }
                    }
                }
            }
        }
    }
    
    
  
    
}
