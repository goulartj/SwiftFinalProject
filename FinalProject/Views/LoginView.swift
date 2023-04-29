//
//  LoginViewView.swift
//  FinalProject
//
//  Created by John Goulart on 4/27/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field {
        case email, password
    }
    let backgroundImage = Image("background")
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var sheetIsPresented = false
    @FocusState private var focusField: Field?
    var body: some View {
        NavigationStack {
            VStack {
                Text("ShuffleTube")
                    .font(.system(size:58))
                    .italic()
                    .foregroundColor(.accentColor)
                    .frame(height:100)
                    .fontWeight(.black)
                    .padding(.bottom)
                Group {
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($focusField, equals: .email)
                        .onSubmit {
                            focusField = .password
                        }
                    
                    TextField("Password", text: $password)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .focused($focusField, equals: .password)
                        .onSubmit {
                            focusField = nil
                        }
                }
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: 2)
                }
                .padding(.horizontal)
                .padding(.bottom)
                Group {
                    Button {
                        register()
                    } label: {
                        Text("Register")
                    }
                    Button {
                        login()
                    } label: {
                        Text("Log In")
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("AccentColor"))
                .foregroundColor(Color("SkyColor"))
                .font(.title)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .fullScreenCover(isPresented: $sheetIsPresented) {
                    PathView()
                }
            }
            .background(backgroundImage.opacity(0.9))
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            }
            .onAppear {
                if Auth.auth().currentUser != nil {
                    print("Login Successful!")
                    sheetIsPresented.toggle()
                }
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result,
            error in
            if let error = error {
                print("Sign-Up Error: \(error.localizedDescription)")
                alertMessage = "Sign-Up Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration Success!")
                sheetIsPresented.toggle()
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result,
            error in
            if let error = error {
                print("Login Error: \(error.localizedDescription)")
                alertMessage = "Login Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Login Successful!")
                sheetIsPresented.toggle()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
