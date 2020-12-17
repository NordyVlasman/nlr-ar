//
//  UserTypeView.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/17/20.
//

import SwiftUI

struct UserTypeView: View {
    enum CurrentUserSelected {
        case repair
        case check
        case visit
    }

    @EnvironmentObject private var appState: AppState

    @State private var show = false
    @State private var currentSelection: CurrentUserSelected = .check
    
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
                Text("Please enter how you're intending to use the app right now. Your experience using the app will be tailored to this choise.")
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
    
    var selectionForm: some View {
        VStack(alignment: .leading) {
            Text("Please pick one")
                .bold()
                .padding(.bottom)
            HStack(alignment: .firstTextBaseline) {
                Button(action: {
                    currentSelection = .check
                }, label: {
                    VStack(alignment: .center) {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                            .foregroundColor(currentSelection == .check ? .white : .gray)
                            .frame(width: 83, height: 83)
                            .background(currentSelection == .check ? Color.CompanyBlue.brightness(0) : Color.gray.brightness(0.3))
                            .clipShape(Circle())
                        Text("I would like to fill in a repair checklist")
                            .padding(.top)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: 208)
                })
                Spacer()
                Button(action: {
                    currentSelection = .repair
                }, label: {
                    VStack {
                        Image(systemName: "wrench.and.screwdriver")
                            .font(.title)
                            .foregroundColor(currentSelection == .repair ? .white : .gray)
                            .frame(width: 83, height: 83)
                            .background(currentSelection == .repair ? Color.CompanyBlue.brightness(0) : Color.gray.brightness(0.3))
                            .clipShape(Circle())
                        Text("I would like to make a repair")
                            .padding(.top)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)

                    }
                    .frame(maxWidth: 208)
                })
                Spacer()
                Button(action: {
                    currentSelection = .visit
                }, label: {
                    VStack {
                        Image(systemName: "figure.wave")
                            .font(.title)
                            .foregroundColor(currentSelection == .visit ? .white : .gray)
                            .frame(width: 83, height: 83)
                            .background(currentSelection == .visit ? Color.CompanyBlue.brightness(0) : Color.gray.brightness(0.3))
                            .clipShape(Circle())
                        Text("I'm only here to visit")
                            .padding(.top)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)

                    }
                    .frame(maxWidth: 208)
                })
            }
        }
        .frame(maxWidth: 874)
        .padding(.top, 50)
        .opacity(show ? 1 : 0)
        .offset(y: show ? 0 : 20)
        .animation(Animation.easeOut(duration: 0.2).delay(0.4))
    }
    
    var continueButton: some View {
        HStack {
            Spacer()
            Button(action: {
                appState.route = .airplaneSelectionView
            }, label: {
                Text("Select this task >")
                    .bold()
                    .foregroundColor(.white)
            })
            .padding(.horizontal, 40)
            .padding(.vertical)
            .background(Color.CompanyBlue)
            .cornerRadius(100)
        }
        .frame(maxWidth: 874)
        .padding(.bottom, 60)
        .opacity(show ? 1 : 0)
        .offset(y: show ? 0 : 20)
        .animation(Animation.easeOut(duration: 0.2).delay(0.4))
    }
    
    var body: some View {
        VStack {
            header
            selectionForm
            Spacer()
            continueButton
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            show = true
        }
    }
}
