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
    
    //MARK: - Application Routes.
    @Published var route: Route = .loginView
    
    enum Route: Identifiable {
        case loginView
        case userTypeView
        case airplaneSelectionView
        case airplaneDetailView
        case arView
        
        var id: String {
            switch self {
            case .loginView: return "loginView"
            case .userTypeView: return "userTypeView"
            case .airplaneSelectionView: return "airplaneSelectionView"
            case .airplaneDetailView: return "airplaneDetailView"
            case .arView: return "arView"
            }
        }
        
        @ViewBuilder
        func makeView() -> some View {
            switch self {
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
            }
        }
    }
    
    func isFirstLaunch() -> Bool {
        if !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore") {
            UserDefaults.standard.setValue(true, forKey: "hasBeenLaunchedBefore")
            return true
        } else {
            //TODO: Reset this to false in the base app!
            return true
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
                Text("Add damage \(nodeName) at \(location.x)")
            case let .showDamageDetail(id):
                Text("Damage Detail \(id)")
            }
        }
    }
    
    //MARK: - Errors
    @Published var currentError: AppErrors?
    
    enum AppErrors: Identifiable {
        case wrongQR
        
        var id: String {
            switch self {
            case .wrongQR: return "wrongQR"
            }
        }
        
        func makeError() -> Alert {
            switch self {
            case .wrongQR:
                return Alert(title: Text("Wrong QR"), message: Text("Wrong QR"), dismissButton: .cancel())
            }
        }
    }
}
