//
//  ShimmerView.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import SwiftUI

public struct ShimmerView: View {
    
    // MARK: Variables
    var shimmerType: ShimmerType
    var listDataCount: Int?
    
    // MARK: initialization
    public init(shimmerType: ShimmerType, listDataCount: Int? = nil) {
        self.shimmerType = shimmerType
        self.listDataCount = listDataCount
    }
    
    /// List count for showing shimmer card.
    private var listCount: Int {
        listDataCount ?? 10
    }
    
    // MARK: body
    public var body: some View {
        content
    }
    
    /// Shimmer view.
    @ViewBuilder
    private var content: some View {
        switch shimmerType {
        case .movieGrid:
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16, alignment: .top), count: 2), spacing: 16) {
                    ForEach(0..<10) { index in
                        MovieCardShimmerView()
                    }
                }
                .padding(.horizontal, .medium)
            }
        case .movieDetail:
            ScrollView(showsIndicators: false) {
                MovieDetailShimmerView()
                    .padding(.all, 20)
            }
        }
    }
}
