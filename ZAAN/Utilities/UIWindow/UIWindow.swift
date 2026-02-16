//
//  Untitled.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 25/11/2025.
//

// Source - https://stackoverflow.com/a
// Posted by Sagar Chauhan
// Retrieved 2025-11-25, License - CC BY-SA 4.0

import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
