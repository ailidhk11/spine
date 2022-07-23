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
    
    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Incorrect info")
            }
            
        }
    }

        
        @ObservedObject var model = ViewModel()
        
    @State private var email = "" //Check if should be @State
    @State private var password = "" //Check if should be @State
    @State private var isUserLoggedIn = false
        
    var body: some View {
        if isUserLoggedIn == false {
            content
        } else {
            homepage.init()
        }
    }
    
    var content: some View {
       // NavigationView {
            
            
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
                            
                            
                            
                            Button {
                                login()
                            } label: {
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
                    
                        VStack {
                            Button {
                                registerUser()
                            } label: {
                                Text("Don't have an account? Register here!")
                                    .font(.headline)
                                    //.padding()
                                    .foregroundColor(.white)
                            } //.position(x: 250, y: -120)
                    }
                }
                
                
                Spacer()
                
            }
            .accentColor(Color(.label))
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        isUserLoggedIn.toggle()
                    }
                }
            }
            
    //    }
    
    }
        

    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                isUserLoggedIn = false
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
    
    struct register: View {
        
        @State private var newEmail = ""
        @State private var newPassword = ""
        @State private var confirmPassword = ""
        @State private var name = ""
        @State private var dob = Date()
        
        var body: some View {
            
            
            
            ZStack {
                Color("Sage")
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Register for a Spine account")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    TextField("Name", text: $name)
                        .placeholder(when: name.isEmpty) {
                            Text("Name")
                        }
                        .padding(20)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Rectangle()
                        .frame(width:400, height:1)
                        .foregroundColor(.white)
    
                    
                    HStack {
                        
                        Text("Date of Birth")
                            .padding()
                            .foregroundColor(.white)
                            .font(.title)
                      

                        DatePicker (
                            "",
                            selection: $dob
                            ).foregroundColor(.white)
                            .padding()
                            .font(.subheadline)
                    }
                    
                    TextField("Email address", text: $newEmail)
                        .placeholder(when: newEmail.isEmpty) {
                            Text("Email address")
                        }
                        .padding(20)
                        .foregroundColor(.white)
                        .font(.title)
                        
        
                    
                    Rectangle()
                        .frame(width:400, height:1)
                        .foregroundColor(.white)
                    
                    VStack {
                    
                    SecureField("Password", text: $newPassword)
                        .placeholder(when: newPassword.isEmpty) {
                            Text("Password")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Rectangle()
                        .frame(width:400, height:1)
                        .foregroundColor(.white)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .placeholder(when: confirmPassword.isEmpty) {
                            Text("Confirm Password")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Rectangle()
                        .frame(width:400, height:1)
                        .foregroundColor(.white)
                        
                    Button {
                        registerUser()
                    } label: {
                        Text("Register")
                    }
                    
                    Spacer()
                        
                    }
                    
                    Spacer()
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
    
    struct register_Previews: PreviewProvider {
        static var previews: some View {
            register()
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
