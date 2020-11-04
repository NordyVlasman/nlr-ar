//
//  DamageDetailView.swift
//  NLR
//
//  Created by Nordy Vlasman on 04/11/2020.
//

import SwiftUI

struct DamageDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var manager: ARManager
        
    var body: some View {
        NavigationView {
            VStack {
                Text(manager.currentDamageNode?.title ?? "")
                    .font(.title)
            }
            .navigationBarTitle("Damage Details")
        }
        .onDisappear {
           manager.showDamageDetails = false
        }
    }
}

struct DamageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DamageDetailView()
    }
}
