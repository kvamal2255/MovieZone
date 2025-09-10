//
//  EmptyState.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import SwiftUI

public struct EmptyState: View {
    
    let title: String
    let description: String
    let imgName: String? = nil
    let action: () -> Void
    
    public var body: some View {
        VStack(spacing: .medium) {
            texts
            actions
        }
        .accessibilityElement(children: .contain)
    }
    
    @ViewBuilder
    var texts: some View {
        VStack(spacing: .xSmall) {
            Text(title)
                .foregroundStyle(Color.black)
                .font(.headline)
            
            Text(description)
                .foregroundStyle(Color.gray)
                .font(.subheadline)
                .padding(.horizontal, .small)
                .multilineTextAlignment(.center)
        }
    }
    
    var actions: some View {
        Button {
            action()
        } label: {
            Text("Retry")
                .foregroundStyle(Color.white)
                .frame(width: 140, height: 40)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}
