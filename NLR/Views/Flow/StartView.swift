//
//  StartView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var manager: AppManager
    @State var showTitle: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                if showTitle {
                    Text("Hello")
                        .font(.system(size: 48, weight: .semibold))
                        .padding()
                        .transition(.opacity)
                }
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
        .onAppear{
            showTitlea()
        }
    }
    
    func showTitlea() {
        withAnimation(.easeInOut(duration: 2), {
            self.showTitle.toggle()
        })
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
