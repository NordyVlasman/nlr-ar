//
//  View+Extensions.swift
//  NLR
//
//  Created by Nordy Vlasman on 04/11/2020.
//

import SwiftUI

extension View {
    //MARK: - Corner radius
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    //MARK: - Bottom Sheet
    func bottomSheet<Content: View>(
            isPresented: Binding<Bool>,
            height: CGFloat,
            topBarHeight: CGFloat = 30,
            topBarCornerRadius: CGFloat? = nil,
            contentBackgroundColor: Color = Color(.systemBackground),
            topBarBackgroundColor: Color = Color(.systemBackground),
            showTopIndicator: Bool = true,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View {
            ZStack {
                self
                BottomSheet(isPresented: isPresented,
                            height: height,
                            topBarHeight: topBarHeight,
                            topBarCornerRadius: topBarCornerRadius,
                            topBarBackgroundColor: topBarBackgroundColor,
                            contentBackgroundColor: contentBackgroundColor,
                            showTopIndicator: showTopIndicator,
                            content: content)
            }
        }
}
