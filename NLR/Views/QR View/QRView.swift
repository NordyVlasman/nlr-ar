//
//  QRView.swift
//  NLR
//
//  Created by Nordy Vlasman on 27/11/2020.
//

import SwiftUI

struct QRView: View {
    
    @Binding var showModal: Bool
    @EnvironmentObject var manager: AppManager

    private let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
    
    private var statusBarHeight: CGFloat {
        (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }
    
    private var scannerView: some View {
        QRScannerView()
            .onFound { code in
                showModal.toggle()
                manager.flowFinished.toggle()
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
