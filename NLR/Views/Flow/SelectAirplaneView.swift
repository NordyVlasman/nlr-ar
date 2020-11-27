//
//  SelectAirplaneView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct SelectAirplaneView: View {
    @EnvironmentObject var manager: AppManager
    @Environment(\.colorScheme) var colorScheme

    @State var number: String = ""
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        Image(systemName: "viewfinder.circle")
                            .font(.system(size: 72))
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    
                    Text("Select a plane to work on")
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
                TextField("Tail number", text: $number)
                Button(action: {
                    manager.flowFinished.toggle()
                }, label: {
                    HStack {
                        Text("Lets Work")
                        Spacer()
                        Image(systemName: "arkit")
                    }
                })
            }
            HStack() {
                Spacer()
                Button(action: {
                    manager.flowFinished.toggle()
                }, label: {
                    Text("Want to scan?")
                })
                Spacer()
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(
                colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground)
            )
            HStack() {
                Spacer()
                Button(action: {
                    manager.flowFinished.toggle()
                }, label: {
                    Text("Show me the list")
                })
                Spacer()
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(
                colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground)
            )
        }
        .listStyle(InsetGroupedListStyle())
    }
}
