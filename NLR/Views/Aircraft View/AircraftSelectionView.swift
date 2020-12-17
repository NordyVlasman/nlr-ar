//
//  AircraftSelectionView.swift
//  NLR
//
//  Created by Nordy Vlasman on 11/25/20.
//

import SwiftUI

struct AircraftSelectionView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var aircraftManager: AircraftManager

    @State private var tailNumber = "F-35 - F001"
    @State private var show = false
    
    @State private var showErrorDialog = false
    
    var header: some View {
        VStack() {
            Spacer()
            HStack(alignment: .center) {
                Text("Select,")
                    .foregroundColor(.white)
                    .font(.system(size: 70))
                    .bold()
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? 0 : 20)
                    .animation(Animation.easeOut(duration: 0.6).delay(0.1))
                Spacer()
                Text("Select which airplane you'd like to work on. Use one of the serveral methods.")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.leading)
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? 0 : 20)
                    .animation(Animation.easeOut(duration: 0.6).delay(0.2))
            }
            .frame(maxWidth: 874)
            .padding(.bottom, 60)
        }
        .frame(maxHeight: 240)
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.gradientFirstColor, .gradientSecondColor]), startPoint: .bottomLeading, endPoint: .topTrailing))
    }
    
    var loginForm: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text("Enter the tail number \nhere:")
                    .bold()
                TextField("Type something...", text: $tailNumber)
                    .padding(10)
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(100)
                    .padding(.top, 10)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Or scane the plane \nusing your camera")
                    .bold()
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                        Text("Open camera")
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                })
                .padding(10)
                .frame(minWidth: 415)
                .background(Color.CompanyBlue)
                .cornerRadius(100)
                .padding(.top, 10)
            }
            .padding(.leading, 20)
        }
        .frame(maxWidth: 874)
        .padding(.top, 50)
        .opacity(show ? 1 : 0)
        .offset(y: show ? 0 : 20)
        .animation(Animation.easeOut(duration: 0.3).delay(0.4))
    }
    
    var continueButton: some View {
        HStack {
            Spacer()
            Button(action: {
                submit()
            }, label: {
                Text("Continue >")
                    .bold()
                    .foregroundColor(.white)
            })
            .padding(.horizontal, 40)
            .padding(.vertical)
            .background(tailNumber.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(100)
            .disabled(tailNumber.isEmpty)
        }
        .frame(maxWidth: 874)
        .padding(.bottom, 60)
        .opacity(show ? 1 : 0)
        .offset(y: show ? 0 : 20)
        .animation(Animation.easeOut(duration: 0.3).delay(0.4))
    }
    
    var body: some View {
        VStack {
            header
            loginForm
            Spacer()
            continueButton
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showErrorDialog, content: {
            Alert(
                title: Text("Model niet gevonden"),
                message: Text("We kunnen het model niet vinden, sorry!"),
                dismissButton: .cancel(Text("Test"))
            )
        })
        .onAppear {
            show = true
        }
    }
    
    func submit() {
        let aircraft = aircraftManager.setCurrentSelectedAirplane(airplane: tailNumber)
        if aircraft == nil {
            showErrorDialog.toggle()
        } else {
            appState.route = .airplaneDetailView
        }
    }
}
