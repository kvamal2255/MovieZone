//
//  FavIconView.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import SwiftUI

struct FavIconView: View {
    
    var isSelected: Bool = false
    let action: () -> Void
    
    public init(isSelected: Bool = false, action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.gray.opacity(0.8)
                    .frame(width: 40, height: 40)
                    .cornerRadius(40 / 2)
                
                Image(isSelected ? .icHeartFill : .icHeartEmpty)
                    .resizable()
                    .frame(width: .large, height: .large)
                
            }
            .frame(width: 44, height: 44)
        }
    }
}

#Preview {
    FavIconView(action: {})
}
