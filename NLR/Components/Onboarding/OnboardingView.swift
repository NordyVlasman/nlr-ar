//
//  OnboardingView.swift
//  NLR
//
//  Created by Nordy Vlasman on 05/11/2020.
//

import SwiftUI

struct OnboardingView: View {
    var page = Onboarding.data.first!
    
    var body: some View {
        VStack {
            Text(page.title)
                .font(.title)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
