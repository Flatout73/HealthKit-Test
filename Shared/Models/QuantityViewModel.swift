//
//  QuantityViewModel.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 19.04.2021.
//

import SwiftUI

struct QuantityViewModel: Identifiable {
    var id: String {
        return DateFormatter().string(from: date)
    }

    let name: String
    let value: Double
    let date: Date
}
