//
//  CheckDamageView.swift
//  NLR
//
//  Created by Nordy Vlasman on 27/11/2020.
//

import SwiftUI

struct CheckDamageView: View {
    @EnvironmentObject var manager: ARManager
    
    var body: some View {
        NavigationView {
            VStack {
                if manager.currentSession != nil {
                    List(manager.currentSession!.damageNodeArray, id: \.self, rowContent: { damage in
                        HStack {
                            Text(damage.title!)
                            Spacer()
                            Text(damage.damageStatus.description)
                        }
                    })
                    .listStyle(InsetGroupedListStyle())
                }
                Text("Alles oke?")
                Button(action: {
                    AppState.shared.currentError = .finishARSession
                }, label: {
                    Text("Joe")
                })
            }
            .navigationBarTitle("Check")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
