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
                Text("Alles oke?")
                Button(action: {
                    checkAlert.toggle()
                }, label: {
                    Text("Joe")
                })
            }
            .alert(isPresented: $checkAlert) {
                Alert(title: Text("Hey"), message: Text("HEY"), primaryButton: .default(Text("JOE"), action: {
                    manager.finish()
                }), secondaryButton: .cancel())
            }
            .navigationBarTitle("Check")
        }
    }
}
