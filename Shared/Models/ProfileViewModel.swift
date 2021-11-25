//
//  ProfileViewModel.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 14.05.2021.
//

import Foundation
import UIKit

struct ProfileViewModel {
    var id: String = UIDevice.current.identifierForVendor?.uuidString ?? "id"
    let name: String
    let email: String

    var measures: [String: [QuantityViewModel]] = [:]
}
