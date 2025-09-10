//
//  AppAppearence.swift
//  MovieZone
//
//  Created by Amal K V on 9/4/25.
//

import UIKit

/// Set Navbar color
public func setNavbarAppearence() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    // background color of the navigation and status bar
    appearance.backgroundColor = UIColor.white
    // Remove the shadow line under navbar
    appearance.shadowColor = .clear
    // color when the title is large
    appearance.largeTitleTextAttributes.updateValue(UIColor.black, forKey: NSAttributedString.Key.foregroundColor)
    // color when the title is small
    appearance.titleTextAttributes.updateValue(UIColor.black, forKey: NSAttributedString.Key.foregroundColor)
    
    // change the background- and title foregroundcolor for navigationbar
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    // change color of navigationbar items
    UINavigationBar.appearance().tintColor = .black
}
