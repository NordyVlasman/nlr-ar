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
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    Text("Hello")
                        .font(.system(size: 48, weight: .semibold))
                        .padding()
                        .transition(.opacity)
                Spacer()

                NavigationLink(
                    destination: AuthenticationView().environmentObject(manager),
                    label: {
                        Text("Get started")
                            .font(.headline)
                    })
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
