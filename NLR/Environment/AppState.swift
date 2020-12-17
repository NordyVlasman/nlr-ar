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
        
        var id: String {
            switch self {
            case .loginView: return "loginView"
            case .userTypeView: return "userTypeView"
            case .airplaneSelectionView: return "airplaneSelectionView"
            case .airplaneDetailView: return "airplaneDetailView"
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
            }
        }
    }
}
