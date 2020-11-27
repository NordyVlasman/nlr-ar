//
//  LoginView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("Sign in using your personal account provided by to you by your employer")
                        .bold()
                        .font(.largeTitle)
                        .padding(50)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250, alignment: .topLeading)
            VStack {
                VStack(alignment: .leading) {
                    Text("Username")
                        .bold()
                    TextField("Username", text: $username)
                        .padding(10)
                        .border(Color.backgroundColor.opacity(10), width: 1)
                        .frame(width: 500)
                    
                    Text("Password")
                        .bold()
                        .padding(.top)
                    SecureField("Password", text: $password)
                        .padding(10)
                        .border(Color.backgroundColor.opacity(10), width: 1)
                        .frame(width: 500)
                    
                    Button(
                        action: {
                            loggedIn.toggle()
                        },
                        label: {
                            Text("Inloggen")
                        })
                    .padding(.top)
                    
                    Spacer()
                    Image("NLR")
                        .padding(.bottom, 50)
                }
                .padding(.top, 40)
            }
            .padding()
        }
    }
}
