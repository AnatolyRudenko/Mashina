//
//  IconManager.swift
//  Vrooom
//
//  Created by Admin on 06.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

struct IconManager {
    private var dark: Bool
    init(dark: Bool) {
        self.dark = dark
        self.switchIcon()
    }
    
    private func switchIcon() {
        if self.shouldSwitchIcon() &&
            UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons))
            && UIApplication.shared.supportsAlternateIcons {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // без этого возвращается ошибка "Operation cancelled"
                typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
                
                let iconName: String? = self.dark ? "mashina_dark" : nil
                let selectorString = "_setAlternateIconName:completionHandler:"
                
                let selector = NSSelectorFromString(selectorString)
                let imp = UIApplication.shared.method(for: selector)
                let method = unsafeBitCast(imp, to: setAlternateIconName.self)
                method(UIApplication.shared, selector, iconName as NSString?, { _ in })
            }
            UserDefaults.standard.set(self.dark, forKey: K.UD.darkTheme)
        }
    }
    
    private func shouldSwitchIcon() -> Bool {
        let wasDarkTheme = UserDefaults.standard.bool(forKey: K.UD.darkTheme)
        return wasDarkTheme != self.dark
    }
}
