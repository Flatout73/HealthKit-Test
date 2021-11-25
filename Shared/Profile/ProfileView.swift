//
//  ProfileView.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 06.05.2021.
//

import SwiftUI

struct ProfileView: View {
    @StateObject
    var vkService = VKService()

    @Binding
    var profile: ProfileViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Категории")) {
                    ForEach(profile.measures.keys.map { String($0) }, id: \.self) { category in
                        NavigationLink(destination: MeasurementView()) {
                            HStack {
                                Text(category)
                            }
                        }
                    }
                }
                Button("Login") {
                    vkService.login()
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(profile.name)
        .navigationBarItems(trailing: AvatarView())
    }
}


