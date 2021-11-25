//
//  VKService.swift
//  SocialHealth
//
//  Created by Leonid Liadveikin on 12.05.2021.
//

import Foundation
import SwiftyVK
import UIKit

class VKService: ObservableObject, SwiftyVKDelegate {

    func login() {
        VK.setUp(appId: "", delegate: self)

        VK.sessions.default.logIn(
              onSuccess: { _ in
                // Start working with SwiftyVK session here
              },
              onError: { _ in
                // Handle an error if something went wrong
              }
          )
    }

    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return [.friends, .email]
    }

    func vkNeedToPresent(viewController: VKViewController) {
        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
