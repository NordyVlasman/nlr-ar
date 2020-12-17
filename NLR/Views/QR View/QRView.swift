//
//  QRView.swift
//  NLR
//
//  Created by Nordy Vlasman on 27/11/2020.
//

import SwiftUI

struct QRView: View {
    
//    @EnvironmentObject var manager: AppManager

    private let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
    
    private var statusBarHeight: CGFloat {
        (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }
    
    private var scannerView: some View {
        QRScannerView()
            .onFound { code in
                print("\(code)")
                let aircraft = AircraftManager.shared.setCurrentSelectedAirplane(airplane: code)
                if aircraft != nil {
                    AppState.shared.sheetRoute = nil
                    AppState.shared.route = .airplaneDetailView
                } else {
                    AppState.shared.sheetRoute = nil
                    AppState.shared.currentError = .wrongQR
                }
                
            }
            .edgesIgnoringSafeArea(.top)
    }
    
    private var scanningAreaRect: some View {
        VStack(alignment: .center, content: {
            Image("QR")
                .resizable()
                .frame(width: 200, height: 200)
                .position(
                    x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2 - 100
                )
        })
    }
    
    var body: some View {
        ZStack {
            scannerView
            scanningAreaRect
        }
    }
}
