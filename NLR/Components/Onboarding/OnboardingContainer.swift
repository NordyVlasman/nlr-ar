//
//  OnboardingItemView.swift
//  NLR
//
//  Created by Nordy Vlasman on 05/11/2020.
//

import SwiftUI

struct OnboardingItemView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    
    @State var currentPage = 0
    @State var buttonText = "Next"
    
    var onComplete: (()->()) = {}
    
    var body: some View {
        VStack {
            PageViewController(currentPage: $currentPage, controllers: viewControllers)
            PageIndicator(currentIndex: currentPage)
            
            VStack {
                Button(action: {
                    if currentPage < viewControllers.count - 1 {
                        currentPage += 1
                    } else {
                        onComplete()
                    }
                }, label: {
                    Text(currentPage == viewControllers.count - 1 ? "Start" : "Volgende")
                        .bold()
                })
            }
        }
    }
}

struct OnboardingItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingItemView(viewControllers: Onboarding.data.map({
            UIHostingController(rootView: OnboardingView(page: $0))
        }))
    }
}
