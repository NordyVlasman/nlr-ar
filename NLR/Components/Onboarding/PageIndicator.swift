//
//  PageIndicator.swift
//  NLR
//
//  Created by Nordy Vlasman on 05/11/2020.
//

import SwiftUI

struct PageIndicator: View {
    
    var currentIndex: Int = 0
    var pagesCount: Int = Onboarding.data.count
    
    var activeColor: Color = .blue
    var inActiveColor: Color = .gray
    
    var body: some View {
        HStack {
            ForEach(0 ..< pagesCount) { i in
                Circle()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundColor(i == currentIndex ? activeColor : inActiveColor)
            }
        }
    }
}
