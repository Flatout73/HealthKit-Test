//
//  HeightView.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 19.04.2021.
//

import SwiftUI
import HealthKit

struct HeightView: View {
    let sample: QuantityViewModel
    let personName: String

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(sample.name)
                Spacer()
                Text(sample.date, formatter: DateFormatter())
            }
            
            HStack {
                Text("\(sample.value) m")
                Spacer()
                Text(personName)
            }
        }
        .padding()
        .background(Color(UIColor.systemFill))
        .cornerRadius(8)
    }
}
