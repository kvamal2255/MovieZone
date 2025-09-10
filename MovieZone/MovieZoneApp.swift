//
//  MovieZoneApp.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import SwiftUI

@main
struct MovieZoneApp: App {
    
    public init() {
        setNavbarAppearence()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
