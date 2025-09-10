//
//  MovieCardShimmerView.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import SwiftUI

struct MovieCardShimmerView: View {
    var body: some View {
        content()
    }
    
    private func content(animation: Skeleton.Animation = .default) -> some View {
        
        ZStack(alignment: .bottomLeading) {
            Skeleton(.atomic(.rectangle), borderRadius: 20)
            
            Skeleton(.text(lines: 2), animation: animation)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .cornerRadius(8)

    }
}

#Preview {
    MovieCardShimmerView()
}
