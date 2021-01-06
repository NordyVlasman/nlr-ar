//
//  ARView.swift
//  NLR
//
//  Created by Nordy Vlasman on 1/6/21.
//

import SwiftUI

struct ARView: View {
    @EnvironmentObject var arManager: ARManager
    
    var arkitOverlay: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    arManager.quitARView()
                }, label: {
                    VStack {
                        Image(systemName: "xmark.square.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                })
            }
            .padding(.top, 10)
            Spacer()
            HStack {
                Spacer()
                if arManager.isObjectEditing {
                    Button(action: {
                        arManager.stopEditingModel()
                    }, label: {
                        VStack {
                            Image(systemName: "checkmark")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .mask(Circle())
                    })
                }
                Spacer()
            }
            .padding(.bottom, 6)
        }
        .padding()
    }
    
    var body: some View {
        ARKitView()
            .overlay(
                arkitOverlay
            )
            .environmentObject(AppManager.shared)
            .environmentObject(arManager)
            .edgesIgnoringSafeArea(.all)
    }
}
