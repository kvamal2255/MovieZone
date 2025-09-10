//
//  MovieCastCollectionView.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import SwiftUI

struct MovieCastCollectionView: View {
    
    let castList: [MovieCastUIViewModel]
    
    public init(castList: [MovieCastUIViewModel]) {
        self.castList = castList
    }
    
    @ViewBuilder
    var body: some View {
        if !castList.isEmpty {
            VStack(alignment: .leading, spacing: .normal) {
                Text("Cast")
                    .font(.system(.headline, weight: .medium))
                    .foregroundStyle(Color.black)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .small) {
                        ForEach(castList, id: \.id) { cast in
                            castView(uiViewModel: cast)
                        }
                    }
                }
            }
        }
    }
    
    private func castView(uiViewModel: MovieCastUIViewModel) -> some View {
        VStack(spacing: .normal) {
            AsyncImageView(imageURLStr: uiViewModel.url ?? "", imageWidth: 45, imageHeight: 45)
                .cornerRadius(45 / 2)
            
            Text(uiViewModel.name)
                .foregroundStyle(Color.black)
                .font(.system(size: 12, weight: .regular))
                .lineLimit(2)
        }
        .frame(width: 46)
    }
}

#Preview {
    MovieCastCollectionView(castList: [])
}
