//
//  GeneralFunctions.swift
//  MovieZone
//
//  Created by Amal K V on 9/9/25.
//

import Foundation

// Function to convert minutes to formatted string like "2h 49min"
public func formatRuntime(minutes: Int) -> String {
    guard minutes > 0 else { return "" }
    
    let hours = minutes / 60
    let remainingMinutes = minutes % 60
    
    if hours > 0 && remainingMinutes > 0 {
        return "\(hours)h \(remainingMinutes)min"
    } else if hours > 0 {
        return "\(hours)h"
    } else {
        return "\(remainingMinutes)min"
    }
}

// Function to convert date string from "2025-09-05" format to "Sept 2025" format
public func formatDate(date: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = formatter.date(from: date) else {
        return date
    }
    
    formatter.dateFormat = "MMM yyyy"
    return formatter.string(from: date).capitalized
}

