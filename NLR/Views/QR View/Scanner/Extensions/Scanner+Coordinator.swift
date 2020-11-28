//
//  Scanner+Coordinator.swift
//  NLR
//
//  Created by Nordy Vlasman on 27/11/2020.
//

import SwiftUI

extension QRScannerView {
    
    class Coordinator: QRScannerViewControllerDelegate {
        func found(code: String) {
            scannerView.found?(code)
        }
        
        private let scannerView: QRScannerView
        
        init(_ scannerView: QRScannerView) {
            self.scannerView = scannerView
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
