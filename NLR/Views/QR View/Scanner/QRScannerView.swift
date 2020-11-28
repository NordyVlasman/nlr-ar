//
//  QRScannerView.swift
//  NLR
//
//  Created by Nordy Vlasman on 27/11/2020.
//

import SwiftUI

struct QRScannerView: UIViewControllerRepresentable {
    internal let found: ((String) -> Void)?
    
    private init(onFound: ((String) -> Void)?) {
        found = onFound
    }
    
    init() {
        found = nil
    }
    
    func onFound(perform action: ((String) -> Void)? = nil) -> some View {
        QRScannerView(onFound: action)
    }
    
    func makeUIViewController(context: Context) -> QRScannerViewController {
        let viewController = QRScannerViewController()
        viewController.delegate = context.coordinator
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {
        //
    }
}
