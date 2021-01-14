//
//  AppState.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/17/20.
//

import SwiftUI
import SceneKit

class AppState: ObservableObject {
    public static let shared = AppState()
    
    init() {
        if isFirstLaunch() {
            route = .onboarding
        }
    }
    
    //MARK: - Application Routes.
    @Published var route: Route = .loginView
    
    enum Route: Identifiable {
        case onboarding
        case loginView
        case userTypeView
        case airplaneSelectionView
        case airplaneDetailView
        case arView
        case checklistView
        
        var id: String {
            switch self {
            case .onboarding: return "onboarding"
            case .loginView: return "loginView"
            case .userTypeView: return "userTypeView"
            case .airplaneSelectionView: return "airplaneSelectionView"
            case .airplaneDetailView: return "airplaneDetailView"
            case .arView: return "arView"
            case .checklistView: return "checklistView"
            }
        }
        
        @ViewBuilder
        func makeView() -> some View {
            switch self {
            case .onboarding:
                OnboardingItemView(viewControllers: Onboarding.data.map({
                                    UIHostingController(rootView: OnboardingView(page: $0))
                                }), onComplete: {
                                    withAnimation {
                                        AppState.shared.route = .loginView
                                    }
                                }).transition(.scale)
            case .loginView:
                LoginView()
            case .userTypeView:
                UserTypeView()
            case .airplaneSelectionView:
                AircraftSelectionView()
                    .environmentObject(AircraftManager.shared)
            case .airplaneDetailView:
                AircraftSessionsView()
                    .environmentObject(AircraftManager.shared)
            case .arView:
                ARView()
                    .environmentObject(ARManager.shared)
            case .checklistView:
                CheckDamageView()
                    .environmentObject(ARManager.shared)
            }
        }
    }
    
    func isFirstLaunch() -> Bool {
        let showOnboarding = Bundle.main.infoDictionary?["LAUNCH_WITH_INTRODUCTION"] as? String
        if showOnboarding == "NO" {
            return false
        }
        
        if !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore") {
            UserDefaults.standard.setValue(true, forKey: "hasBeenLaunchedBefore")
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Sheet routes
    @Published var sheetRoute: SheetRoute?
    
    enum SheetRoute: Identifiable {
        case showQR
        case showAddDamage(location: SCNVector3, nodeName: String)
        case showDamageDetail(id: String)
        
        var id: String {
            switch self {
            case .showQR: return "showQR"
            case .showAddDamage(_, _): return "showAddDamage"
            case .showDamageDetail(_): return "showDamageDetail"
            }
        }
        
        @ViewBuilder
        func makeSheet() -> some View {
            switch self {
            case .showQR:
                QRView()
            case let .showAddDamage(location, nodeName):
                AddDamageView(location: location, nodeName: nodeName)
            case let .showDamageDetail(id):
                Text("Damage Detail \(id)")
            }
        }
    }
    
    //MARK: - Errors
    @Published var currentError: AppErrors?
    
    enum AppErrors: Identifiable {
        case wrongQR
        case finishARSession
        
        var id: String {
            switch self {
            case .wrongQR: return "wrongQR"
            case .finishARSession: return "finishARSession"
            }
        }
        
        func makeError() -> Alert {
            switch self {
            case .wrongQR:
                return Alert(title: Text("Wrong QR"), message: Text("Wrong QR"), dismissButton: .cancel())
            case .finishARSession:
                return Alert(title: Text("Weet je het zeker?"),
                             message: Text("Weet je zeker dat je je sessie wilt afronden?"),
                             primaryButton: .default(Text("Ja"), action: {
                                AppState.shared.route = .airplaneSelectionView
                                AppState.shared.currentError = .none
                             }),
                             secondaryButton: .cancel())
            }
        }
    }
}
