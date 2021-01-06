//
//  FeedbackGenerator.swift
//  NLR
//
//  Created by Nordy Vlasman on 1/6/21.
//

import Foundation
import UIKit

class FeedbackGenerator {
    static let shared = FeedbackGenerator()
    
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private let selectionGenerator = UISelectionFeedbackGenerator()
    
    func triggerNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.prepare()
        notificationGenerator.notificationOccurred(type)
    }
    
    func triggerSelection() {
        selectionGenerator.prepare()
        selectionGenerator.selectionChanged()
    }
}
