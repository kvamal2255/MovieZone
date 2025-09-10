//
//  Skelton.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import SwiftUI

public struct Skeleton: View {
    
    public static let color: Color = .cloudNormal
    public static let lightColor: Color = .cloudLight
    
    @State var color: Color = Self.color
    
    let preset: Preset
    let borderRadius: CGFloat
    let animation: Animation
    
    public var body: some View {
        content
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(animation.value?.repeatForever()) {
                        color = Self.lightColor
                    }
                }
            }
    }
    
    @ViewBuilder var content: some View {
        switch preset {
        case .atomic(let atomic):
            switch atomic {
            case .circle:
                Circle().fill(color)
            case .rectangle:
                roundedRectangle.fill(color)
            }
        case .card(let height), .image(let height):
            roundedRectangle.fill(color).frame(height: height)
        case .list(let rows, let rowHeight, let spacing):
            VStack(spacing: spacing) {
                ForEach(0 ..< rows, id: \.self) { _ in
                    HStack(spacing: spacing) {
                        roundedRectangle.fill(color).frame(width: rowHeight, height: rowHeight)
                        roundedRectangle.fill(color).frame(height: rowHeight)
                    }
                }
            }
        case .text(let lines, let lineHeight, let spacing):
            VStack(spacing: spacing) {
                ForEach(0 ..< lines, id: \.self) { index in
                    if index == lines - 1 {
                        Color.clear.frame(height: lineHeight)
                            .overlay(
                                GeometryReader { geometry in
                                    line(height: lineHeight)
                                        .frame(width: geometry.size.width * 0.7)
                                }
                            )
                    } else {
                        line(height: lineHeight)
                    }
                }
            }
        }
    }
    
    var roundedRectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: borderRadius)
    }
    
    @ViewBuilder func line(height: CGFloat) -> some View {
        roundedRectangle.fill(color).frame(height: height)
    }
}

// MARK: - Types
extension Skeleton {
    
    public enum Preset {

        public enum Atomic {
            case circle
            case rectangle
        }

        case atomic(Atomic)
        case card(height: CGFloat? = nil)
        case image(height: CGFloat? = nil)
        case list(rows: Int, rowHeight: CGFloat = 20, spacing: CGFloat = .xSmall)
        case text(lines: Int, lineHeight: CGFloat = 20, spacing: CGFloat = .xSmall)
    }

    public enum Animation {
        case none
        case `default`
        case custom(SwiftUI.Animation)

        var value: SwiftUI.Animation? {
            switch self {
                case .none:                     return nil
                case .default:                  return .easeInOut(duration: 1.2)
                case .custom(let animation):    return animation
            }
        }
    }
}

// MARK: - Inits
public extension Skeleton {
 
    init(
        _ preset: Preset,
        borderRadius: CGFloat = .xSmall,
        animation: Animation = .default
    ) {
        self.preset = preset
        self.borderRadius = borderRadius
        self.animation = animation
    }
}
