//
//  AircraftSelectionView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct AircraftSelectionView: View {
    @EnvironmentObject var manager: ARManager
    
    @Binding var showNumberStyle: Bool
    @State var number: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("Welcome! You can choose to either search for a plane by it's tail number or use the advanced search tool")
                        .bold()
                        .font(.largeTitle)
                        .padding(50)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250, alignment: .topLeading)
            VStack {
                VStack(alignment: .leading) {
                    Text("Tail number")
                        .bold()
                    TextField("Tail number", text: $number)
                        .padding(10)
                        .border(Color.backgroundColor.opacity(10), width: 1)
                        .frame(width: 500)
                    Button(
                        action: {
                            showNumberStyle.toggle()
                        },
                        label: {
                            HStack {
                                Text("Or go to the advanced search list")
                                    .underline()
                                Image(systemName: "chevron.compact.right")
                            }
                        })
                        .padding(.top)
                    
                    Spacer()
                    Image("NLR")
                        .padding(.bottom, 50)
                }
                .padding(.top, 70)
            }
        }
    }
}
