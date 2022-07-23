//
//  ContentView.swift
//  spinev4
//
//  Created by Ailidh Kinney on 20/07/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct MainView: View {

        
        @ObservedObject var model = ViewModel()
        
    @State private var email = "" //Check if should be @State
    @State private var password = "" //Check if should be @State
        
        var body: some View {
            
           
            
            NavigationView {
        
            
                ZStack {
                    Color("Sage")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        // Spacer()
                        
                        Text("Welcome to Spine")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .padding([.top, .leading, .trailing])
                            .position(x: 140, y: 150)
                        
                        // Spacer()
                        
                        HStack {
                            Image("Books spine out ")
                                .resizable()
                                .frame(width: 600, height: 200)
                            // Do I want this?
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                                .position(x: 120, y: -90)
                            
                            VStack {
                                
                                //    Text("Email")
                                //     .font(.headline)
                                TextField("Email", text: $email)
                                    
                                    .placeholder(when: email.isEmpty) {
                                        Text("Email")
                                    }
                                    .foregroundColor(.white)
                                    .position(x: 130, y: -130)
                                
                                Rectangle()
                                    .frame(width:165, height:1)
                                    .foregroundColor(.white)
                                    .position(x: 105, y: -190)
                                
                                //  Text("Password")
                                //    .font(.headline)
                                // Space before password to move word slightly
                                
                                SecureField("Password", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Password")
                                    }
                                    .foregroundColor(.white)
                                    .position(x: 130, y: -210)
                            
                            Rectangle()
                                .frame(width:165, height:1)
                                .foregroundColor(.white)
                                .position(x: 105, y: -270)
                            
                            NavigationLink(destination: homepage()) {
                                Text("Log In")
                                    .frame(minWidth: 0, maxWidth: 300)
                                    .padding()
                                    .padding([.leading, .trailing])
                                    .foregroundColor(.white)
                                //.background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                    .font(.title)
                                    
                            }.position(x: 110, y: -300)
                            }
                        }
                        
                      //  VStack {
                        //    Text("Don't have an account?")
                      //  }
                        
                     //   NavigationLink(destination: register() )
                   }
                    
                    
                    Spacer()
                    
                }
                .accentColor(Color(.label))
                
            } //Body end
        }
        
    func register() {
         Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
               print("Incorrect info")
            }
            
        }
   }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                print("Sorry, those details don't look quite right, please try again!")
            }
        }
    }
    
  // } //Content view end



struct homepage: View {
    
    @ObservedObject var model = ViewModel()

    
    
    var body: some View {
            ZStack {
                
                Color("Sage")
                    .ignoresSafeArea()
                
                VStack {
                    
                    
                    Text("Welcome back, Ailidh!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    //.position(x: 205, y: 120)
                    
                    
                    Text("Currently reading:")
                        .font(.title3)
                        .foregroundColor(.white)
                    // .position(x: 125, y: -160)
                    
                    HStack {
                        
                        NavigationLink(destination: Text("HTKYF page"), label: {
                            Image("htkyf")
                                .resizable()
                                .frame(width: 120, height:170)
                                .shadow(radius: 20)
                            // .position(x: 120, y: -370)
                        })
                        VStack {
                            Text("How to Kill your Family")
                                .font(.title3)
                                .foregroundColor(.white)
                            // .position(x: 100, y: -450)
                            NavigationLink(destination: Text("Bella Mackie page"), label: {
                                Text("by Bella Mackie")
                                    .font(.subheadline)
                                    .underline()
                                    .foregroundColor(.white)
                                // .position(x: 100, y: -590)
                            })
                        }
                    }
                    
                
            }
        }
    }
}
   




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct homepage_Previews: PreviewProvider {
    static var previews: some View {
        homepage()
    }
}
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
    alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
    }
}
