//
//  AppState.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/17/20.
//

import SwiftUI

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
                ARKitView()
                    .environmentObject(AppManager.shared)
                    .environmentObject(ARManager.shared)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    //MARK: - Sheet routes
    @Published var sheetRoute: SheetRoute?
    
    enum SheetRoute: Identifiable {
        case showQR
        case showAddDamage
        case showDamageDetail
        
        var id: String {
            switch self {
            case .showQR: return "showQR"
            case .showAddDamage: return "showAddDamage"
            case .showDamageDetail: return "showDamageDetail"
            }
        }
        
        @ViewBuilder
        func makeSheet() -> some View {
            switch self {
            case .showQR:
                QRView()
            case .showAddDamage:
                Text("Add damage")
            case .showDamageDetail:
                Text("Damage Detail")
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
