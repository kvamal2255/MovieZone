//
//  AsyncImageView.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import SwiftUI
import NukeUI
import Nuke

public struct AsyncImageView<Content: View>: View {
    let imageURLStr: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let placeHolderWidth: CGFloat
    let placeHolderHeight: CGFloat
    let contentMode: ContentMode
    var options: ImageRequest.Options
    @ViewBuilder let content: Content
    
    /// Computes image resize processors based on target dimensions
    /// If fixed height is provided, uses that as reference
    /// Otherwise falls back to screen dimensions to optimize memory usage
    private var resizeProcessors: [ImageProcessing] {
        let targetWidth: CGFloat
        let targetHeight: CGFloat
        
        if imageHeight.isFinite {
            // If we have a fixed height, use that as reference
            targetHeight = imageHeight
            targetWidth = imageWidth.isFinite ? imageWidth : imageHeight
        } else {
            // For infinite dimensions, use screen size as reference to avoid memory issues
            targetWidth = screenWidth / 2  // Half screen width
            targetHeight = screenHeight / 2 // Half screen height
        }
        
        return [
            ImageProcessors.Resize(
                size: CGSize(width: targetWidth, height: targetHeight),
                unit: .points,
                contentMode: contentMode == .fill ? .aspectFill : .aspectFit
            )
        ]
    }

    public init(imageURLStr: String,
                imageWidth: CGFloat = .infinity,
                imageHeight: CGFloat = .infinity,
                contentMode: ContentMode = .fill,
                placeHolderWidth: CGFloat = 40,
                placeHolderHeight: CGFloat = 40,
                options: ImageRequest.Options = [],
                @ViewBuilder content: () -> Content
    ) {
        self.imageURLStr = imageURLStr
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.placeHolderWidth = placeHolderWidth
        self.placeHolderHeight = placeHolderHeight
        self.contentMode = contentMode
        self.options = options
        self.content = content()
    }
    
    public var body: some View {
        LazyImage(
            request: ImageRequest(
                url: URL(string: imageURLStr),
                processors: resizeProcessors,
                options: options
            )
        ) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .modifier(FrameModifier(width: imageWidth, height: imageHeight))
                    .clipped()
            } else if state.isLoading {
                imagePlaceHolder
            } else {
                imagePlaceHolder
            }
        }
    }
    
    @ViewBuilder
    var imagePlaceHolder: some View {
        Image(.icImagePlaceholder)
            .resizable()
            .frame(maxWidth: imageWidth, maxHeight: imageHeight)

    }
    
    @ViewBuilder
    var defaultProgressView: some View {
        ProgressView()
            .frame(width: placeHolderWidth, height: placeHolderHeight)
    }
}

// MARK: - Inits
public extension AsyncImageView {
    init(imageURLStr: String,
         imageWidth: CGFloat = .infinity,
         imageHeight: CGFloat = .infinity,
         contentMode: ContentMode = .fill,
         placeHolderWidth: CGFloat = 40,
         placeHolderHeight: CGFloat = 40,
         options: ImageRequest.Options = []) where Content == EmptyView {
        self.init(imageURLStr: imageURLStr,
                  imageWidth: imageWidth,
                  imageHeight: imageHeight,
                  contentMode: contentMode,
                  placeHolderWidth: placeHolderWidth,
                  placeHolderHeight: placeHolderHeight,
                  options: options,
                  content: { EmptyView() })
    }
}

/// A modifier that handles frame sizing logic for images
/// Applies frame constraints based on which dimensions are finite
/// This prevents layout issues when working with .infinity dimensions
private struct FrameModifier: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        if width.isFinite && height.isFinite {
            // Both dimensions are finite - apply fixed frame
            content.frame(width: width, height: height)
        } else if width.isFinite {
            // Only width is finite
            content
                .frame(width: width)
                .frame(maxHeight: .infinity)
        } else if height.isFinite {
            // Only height is finite
            content
                .frame(height: height)
                .frame(maxWidth: .infinity)
        } else {
            // Both dimensions are infinite - set the max height and max width
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
