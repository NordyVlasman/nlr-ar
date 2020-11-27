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
            Image(page.image)
                .resizable()
                .frame(width: 300, height: 250, alignment: .center)
            Text(page.title)
                .bold()
                .font(.largeTitle)
            
            Text(page.description)
                .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
