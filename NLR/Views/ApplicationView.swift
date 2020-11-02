//
//  ContentView.swift
//  NLR
//
//  Created by Nordy Vlasman on 29/10/2020.
//

import SwiftUI

struct ApplicationView: View {
    @StateObject var arManager = ARManager()

    var body: some View {
        ARKitView()
            .environmentObject(arManager)
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                arManager.start()
                arManager.download()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
