//
//  SearchBarModifier.swift
//  MovieZone
//
//  Created by Amal K V on 9/10/25.
//

import Foundation
import SwiftUI

public struct SearchBarModifier: ViewModifier {
    
    // MARK: initialization
    public init() { }
    
    // MARK: body
    public func body(content: Content) -> some View {
        content
            .padding(.vertical, 12)
            .padding(.horizontal, listEdgeInsets().leading)
            .frame(maxWidth: readableMaxWidth)
            .padding(.horizontal, 0)
            .frame(maxWidth: .infinity)
    }
}

/// This extension is written to reduce the code while calling SearchBarListModifier, by use of this extension:
extension GlobalSearchbarView {
    public func listModifier() -> some View {
        modifier(SearchBarModifier())
    }
}

/// Set List Padding using `EdgeInsets`
public func listEdgeInsets() -> EdgeInsets {
    .init(top: 6, leading: 10, bottom: 6, trailing: 10)
}

public let readableMaxWidth: CGFloat = 760
