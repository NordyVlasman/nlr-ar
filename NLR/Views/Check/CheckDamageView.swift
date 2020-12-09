//
//  CheckDamageView.swift
//  NLR
//
//  Created by Nordy Vlasman on 27/11/2020.
//

import SwiftUI

struct CheckDamageView: View {
    @EnvironmentObject var manager: ARManager

    @State var checkAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if manager.currentSession?.damageNodeArray != nil {
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
                    checkAlert.toggle()
                }, label: {
                    Text("Joe")
                })
            }
            .alert(isPresented: $checkAlert) {
                Alert(title: Text("Weet je het zeker?"),
                      message: Text("Weet je zeker dat je je sessie wilt afronden?"),
                      primaryButton: .default(Text("Ja"), action: {
                        manager.finish()
                      }),
                      secondaryButton: .cancel())
            }
            .navigationBarTitle("Check")
        }
    }
}
