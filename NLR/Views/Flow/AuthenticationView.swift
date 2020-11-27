//
//  AuthenticationView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct AuthenticationView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var manager: AppManager

    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        Image(systemName: "lock.open")
                            .font(.system(size: 72))
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    
                    Text("Log in to get started")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(
                colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground)
            )
            Section {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            Section {
                NavigationLink(
                    destination: SelectAirplaneView().environmentObject(manager),
                    label: {
                        Text("Inloggen")
                            .font(.headline)
                            .padding(.vertical, 12)
                    })
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}
