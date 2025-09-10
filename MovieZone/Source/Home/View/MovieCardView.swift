//
//  MovieCardView.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import SwiftUI

struct MovieCardView: View {
    
    let movie: MovieListUIViewModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(imageURLStr: movie.imageUrl ?? "", imageHeight: 210, contentMode: .fill)
                .aspectRatio(2/3, contentMode: .fill)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: .xSmall) {
                    Image(.icRatingStar)
                        .resizable()
                        .frame(width: .normal, height: .normal)
                    
                    Text(movie.rating)
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                }
            }
            .padding(.leading, .small)
            .padding(.bottom, .normal)
            
        }
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
