//
//  SplashView.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import SwiftUI

struct SplashView: View {
    
    @State private var showHome: Bool = false
    
    var body: some View {
        if showHome {
            MovieHomeView()
        } else {
            contentView
        }
    }
    
    private var contentView: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: .medium) {
                Image(.icSplashLogo)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("Movie Zone")
                    .foregroundStyle(Color.black)
                    .fontWeight(.bold)
                    .font(.title2)
            }
        }
        .onAppear {
            withAnimation {
                onAppearSplash()
            }
        }
    }
    
    private func onAppearSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showHome = true
        }
    }
}

#Preview {
    SplashView()
}
