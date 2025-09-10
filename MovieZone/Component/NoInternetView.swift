//
//  NoInternetView.swift
//  MovieZone
//
//  Created by Amal K V on 9/7/25.
//

import SwiftUI

public struct NoInternetState: View {
    var retryAction: () -> Void
    
    public init(retryAction: @escaping () -> Void) {
        self.retryAction = retryAction
    }
    
    public var body: some View {
        EmptyState(
            title: "Offline",
            description: "No internet connection",
            action: retryAction)
    }
}
