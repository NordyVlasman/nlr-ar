//
//  LoginView.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/17/20.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState

    @State private var username = ""
    @State private var password = ""
    
    @State var show: Bool = false
    
    var header: some View {
        VStack() {
            Spacer()
            HStack(alignment: .center) {
                Text("Sign in,")
                    .foregroundColor(.white)
                    .font(.system(size: 70))
                    .bold()
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? 0 : 20)
                    .animation(Animation.easeOut(duration: 0.6).delay(0.1))
                Spacer()
                Text("Please sign in to your account using the account information \nprovided to you by your employer.")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.leading)
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? 0 : 20)
                    .animation(Animation.easeOut(duration: 0.6).delay(0.4))
            }
            .frame(maxWidth: 874)
            .padding(.bottom, 60)
        }
        .frame(maxHeight: 240)
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.gradientFirstColor, .gradientSecondColor]), startPoint: .bottomLeading, endPoint: .topTrailing))
    }
    
    var loginForm: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text("Username")
                    .bold()
                TextField("Type something...", text: $username)
                    .padding(10)
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(100)
                    .padding(.top, 10)
            }
            VStack(alignment: .leading) {
                Text("Password")
                    .bold()
                SecureField("Type something...", text: $password)
                    .padding(10)
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(100)
                    .padding(.top, 10)
            }
            .padding(.leading, 20)
        }
        .frame(maxWidth: 874)
        .padding(.top, 50)
        .opacity(show ? 1 : 0)
        .offset(y: show ? 0 : 20)
        .animation(Animation.easeOut(duration: 0.6).delay(0.6))
    }
    
    var loginButton: some View {
        HStack {
            Spacer()
            Button(action: {
                appState.route = .userTypeView
            }, label: {
                Text("Sign in >")
                    .bold()
                    .foregroundColor(.white)
            })
            .padding(.horizontal, 40)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(100)
        }
        .frame(maxWidth: 874)
        .padding(.bottom, 60)
        .opacity(show ? 1 : 0)
        .offset(x: show ? 0 : 20)
        .animation(Animation.easeOut(duration: 0.6).delay(0.6))
    }
    
    var body: some View {
        VStack {
            header
            loginForm
            Spacer()
            loginButton
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            withAnimation {
                show = true
            }
        }
    }
}
