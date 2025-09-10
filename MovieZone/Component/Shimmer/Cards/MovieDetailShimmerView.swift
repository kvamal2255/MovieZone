//
//  MovieDetailShimmerView.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import SwiftUI

struct MovieDetailShimmerView: View {
    var body: some View {
        content()
    }
    
    private func content(animation: Skeleton.Animation = .default) -> some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack {
                headerView()
                
                VStack(alignment: .leading, spacing: .small) {
                    Skeleton(.text(lines: 2), animation: animation)
                    
                    Skeleton(.text(lines: 2), animation: animation)
                    
                    basicInfoShimmerView()
                    basicInfoShimmerView()
                    basicInfoShimmerView()
                    
                    Spacer()
                }
                .frame(height: 300, alignment: .leading)
            }
            
            Skeleton(.atomic(.rectangle), borderRadius: 6).frame(width: 70, height: 20)
            
            Skeleton(.atomic(.rectangle), borderRadius: 6).frame(width: screenWidth - 40, height: 70)
            
            Skeleton(.text(lines: 2), animation: animation)
            
            Skeleton(.text(lines: 2), animation: animation)
            
            Skeleton(.text(lines: 2), animation: animation)
        }
    }
    
    private func headerView(animation: Skeleton.Animation = .default) -> some View {
        ZStack(alignment: .bottomLeading) {
            Skeleton(.atomic(.rectangle), borderRadius: 6).frame(width: (screenWidth / 2) - 20, height: 300)
            
            Skeleton(.text(lines: 2), animation: animation)
                .padding(.leading)
        }
        
    }
    
    private func basicInfoShimmerView() -> some View {
        HStack {
            Skeleton(.atomic(.rectangle), borderRadius: 6).frame(width: 70, height: 20)
            
            Spacer()
            
            Skeleton(.atomic(.rectangle), borderRadius: 6).frame(width: 70, height: 20)
        }
    }
}

#Preview {
    MovieDetailShimmerView()
}
