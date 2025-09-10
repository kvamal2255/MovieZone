//
//  BasicInfoView.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import SwiftUI

struct BasicInfoView: View {
    
    let title: String
    let description: String
    let titleFont: Font
    let spacing: CGFloat
    
    public init(title: String, description: String, titleFont: Font = .system(.subheadline, weight: .regular), spacing: CGFloat = 10) {
        self.title = title
        self.description = description
        self.titleFont = titleFont
        self.spacing = spacing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(title)
                .font(titleFont)
                .foregroundStyle(Color.black)
            
            Text(description)
                .font(.system(.caption, weight: .regular))
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    BasicInfoView(title: "", description: "")
}
