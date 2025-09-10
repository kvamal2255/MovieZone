//
//  SafeAreaPaddingModifier.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import Foundation
import SwiftUI

public extension View {
    func safeAreaPadding(_ edge: SafeAreaPaddingModifier.Edge) -> some View {
        self.modifier(SafeAreaPaddingModifier(edge: edge))
    }
}

public struct SafeAreaPaddingModifier: ViewModifier {
    public enum Edge {
        case bottom
        case top
        case vertical
    }
    
    @Environment(\.safeAreaInsets) private var safeArea
    var edge: Edge

    public func body(content: Content) -> some View {
        switch edge {
        case .bottom:
            content
                .padding(.bottom, safeArea.bottom)
        case .top:
            content
                .padding(.top, safeArea.top)
        case .vertical:
            content
                .padding(.top, safeArea.top)
                .padding(.bottom, safeArea.bottom)
        }
        
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

public extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
