//
//  ContentView.swift
//  Shared
//
//  Created by Leonid Liadveikin on 17.04.2021.
//

import SwiftUI

struct FeedView: View {

    @ObservedObject
    var healthService: HealthService

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(healthService.samples.flatMap({ $0.value })) { sample in
                        NavigationLink(destination: ProfileView(profile: $healthService.profile)) {
                            HeightView(sample: sample, personName: "Leonid")
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Лента", displayMode: .large)
        }
        .onAppear() {
            healthService.authorize()
            healthService.collectData() { _ in }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
