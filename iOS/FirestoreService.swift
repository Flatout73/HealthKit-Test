//
//  FirestoreService.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 14.05.2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreSwiftTarget

final class FirestoreService {

    lazy var db = Firestore.firestore()

    init() {
        FirebaseApp.configure()
    }

    func saveToStore(for profile: ProfileViewModel) {
        let user = db.collection("users").document(profile.id)
        let data: [String: Any] = [
            "email": profile.email,
            "name": profile.name
        ]
        user.setData(data)

        let measures = user.collection("healthMeasures")
        for (key, value) in profile.measures {
            value.forEach {
                measures.document("\(profile.id)_\(key)").setData([
                    "type": key,
                    "value": $0.value,
                    "date": $0.date
                ])
            }
        }
    }
}
