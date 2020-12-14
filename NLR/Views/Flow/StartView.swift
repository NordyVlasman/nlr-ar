//
//  StartView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var manager: AppManager
    
    @State var username: String = ""
    @State var password: String = ""
    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Spacer()
//                    Text("Hello")
//                        .font(.system(size: 48, weight: .semibold))
//                        .padding()
//                        .transition(.opacity)
//                Spacer()
//
//                NavigationLink(
//                    destination: AuthenticationView().environmentObject(manager),
//                    label: {
//                        Text("Get started")
//                            .font(.headline)
//                    })
//            }
//            .padding()
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Sign in,")
                    .foregroundColor(.white)
                    .font(.system(size: 70))
                    .bold()
                    .padding([.trailing, .top])
                Text("Please sign in to your account using the account information \nprovided to you by your employer")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.top)
                Spacer()
            }
            .frame(minHeight: 240)
            .background(LinearGradient(gradient: Gradient(colors: [.gradientFirstColor, .gradientSecondColor]), startPoint: .bottomLeading, endPoint: .topTrailing))
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Username")
                        .bold()
                    TextField("Username", text: $username)
                        .padding(10)
                        .background(
                            Color.gray
                                .brightness(0.4)
                        )
                        .cornerRadius(100)
                        .frame(width: 350, height: 50)
                }
                VStack(alignment: .leading) {
                    Text("Password")
                        .bold()
                    SecureField("Password", text: $password)
                        .padding(10)
                        .background(
                            Color.gray
                                .brightness(0.4)
                        )
                        .cornerRadius(100)
                        .frame(width: 350, height: 50)
                }
                .padding(.leading, 45)
                Spacer()
            }
            .frame(maxWidth: 874)
            .padding(.top, 50)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Sign in")
                        .bold()
                        .foregroundColor(.white)
                })
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom])
                .background(LinearGradient(gradient: Gradient(colors: [.gradientFirstColor, .gradientSecondColor]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(100)
            }
            .frame(maxWidth: 874)
            .padding(.bottom, 50)
        }
        .edgesIgnoringSafeArea(.top)
    }
    
}

extension AnyTransition {
    static func moveOrFade(edge: Edge) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: edge),
            removal: .opacity
        )
    }
}
