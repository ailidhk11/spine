//
//  ContentView.swift
//  spinev4
//
//  Created by Ailidh Kinney on 20/07/2022.
//Cannot convert value of type 'Published<String>.Publisher' to expected argument type 'Binding<String>'

import SwiftUI
import Firebase
import FirebaseFirestore





struct MainView: View {
    


        
    @EnvironmentObject var model: ViewModel
    
    
    //State properties are normally declared in the view that depends on them
   // @Published private var email = "" //Check if should be @State
    //@Published private var password = "" //Check if should be @State
    //@Published private var isUserLoggedIn = false
        
    //Determines which view to show if the user is logged in or not
    var body: some View {
        if model.isUserLoggedIn == false {
            content
        } else {
            homepage()
        }
    }
    
  

    var content: some View {
        NavigationView {
            
            //A ZStack to allow SAGE background
            ZStack {
                Color("Sage")
                    .ignoresSafeArea()
                
                //A V Stack of the welcome text and an H Stack
                VStack(spacing: 20) {
                    // Spacer()
                    
                    Text("Welcome to Spine")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding([.top, .leading, .trailing])
                        .position(x: 140, y: 150)
                    
                    // Spacer()
                    // An H stack of the image and a VStack
                    HStack {
                        Image("Books spine out ")
                            .resizable()
                            .frame(width: 600, height: 200)
                        // Do I want this?
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                            .position(x: 120, y: -90)
                        
                        // A V stack of email and password fields
                        VStack {
                            
                            //    Text("Email")
                            //     .font(.headline)
                            TextField("Email", text: $model.email)
                            
                                .placeholder(when: model.email.isEmpty) {
                                    Text("Email")
                                }
                                .foregroundColor(.white)
                                .position(x: 130, y: -130)
                                .autocapitalization(.none)
                            
                            Rectangle()
                                .frame(width:165, height:1)
                                .foregroundColor(.white)
                                .position(x: 105, y: -190)
                            
                            //  Text("Password")
                            //    .font(.headline)
                            // Space before password to move word slightly
                            
                            SecureField("Password", text: $model.password)
                                .placeholder(when: model.password.isEmpty) {
                                    Text("Password")
                                }
                                .foregroundColor(.white)
                                .position(x: 130, y: -210)
                                .autocapitalization(.none)
                            
                            Rectangle()
                                .frame(width:165, height:1)
                                .foregroundColor(.white)
                                .position(x: 105, y: -270)
                            
                            
                            //The login button to take us to the home page
                            Button {
                                model.login(email: model.email, password: model.password)
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
                            NavigationLink(destination: register()) {
                                Text("Don't have an account? Register here!")
                                    .font(.headline)
                                    //.padding()
                                    .foregroundColor(.white)
                            } //.position(x: 250, y: -120)


                    }
                }
                
                
                Spacer()
    }
            }
            .accentColor(Color(.label))
            .onAppear {
                //Check what addStateDidChangeListener means?
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        model.isUserLoggedIn.toggle()
                    }
                }
            }
            
    //    }
    
    }
        

    

    
  // } //Content view end



    struct homepage: View {
        
        @EnvironmentObject var model: ViewModel
        

        
        var body: some View {
            ZStack {
                
                Color("Sage")
                    .ignoresSafeArea()
                
                VStack {
                    
                    Button {
                        
                      model.signOut()

                    } label: {
                        Text("Sign out")
                    }
                    .fullScreenCover(isPresented: $model.isUserLoggedIn, onDismiss: nil) {
                        MainView()
                    }
                    
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
        
        @EnvironmentObject var model: ViewModel
          
        @State  var newEmail = ""
        @State var newPassword = ""
        @State var confirmPassword = ""
        @State var name = ""
        @State  var dob = Date()
        
        var body: some View {

            ZStack {
                Color("Sage")
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Register for a Spine account")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
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
                            selection: $dob,
                            displayedComponents: [.date]
                            ).accentColor(.black)
                            .padding()
                            
                    }
                    
                    TextField("Email address", text: $newEmail)
                        .placeholder(when: newEmail.isEmpty) {
                            Text("Email address")
                        }
                        .padding(20)
                        .foregroundColor(.white)
                        .font(.title)
                        .autocapitalization(.none)
                        
        
                    
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
                        .autocapitalization(.none)
                    
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
                        .autocapitalization(.none)
                    
                    Rectangle()
                        .frame(width:400, height:1)
                        .foregroundColor(.white)
                        
                    Spacer()
                        
                    Button {
                        model.registerUser(email: newEmail, password: newPassword)
                    } label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title2)
                            .padding()
                    }
                    
                    Spacer()
                        
                    }
                    
                    Spacer()
                }
            }
            
            
        }
        
        
    }

    struct search: View {
        
        @ObservedObject var model = ViewModel()

        
        var body: some View {
            
            NavigationView {
                
                VStack {
                    
                    List(model.list) {item in
                        
                        HStack {
                            
                            Text(item.title)
                            
                            Divider()

                            
                            Text(item.author)
                            
                            //Only add if necessary later
                          /*  Button  (action: {
                                //see more about book
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.right.circle")
                            }) */
                            
                            Divider()
                            
                            Button (action: {
                                //add to TBR or currentlry reading - maybe a pop up?
                            }, label: {
                                Image(systemName: "plus")
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
    
    struct register_Previews: PreviewProvider {
        static var previews: some View {
            register()
        }
    }
    
    struct search_Previews: PreviewProvider {
        static var previews: some View {
            search()
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
