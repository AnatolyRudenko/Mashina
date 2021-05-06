//
//  IconManager.swift
//  Vrooom
//
//  Created by Admin on 06.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

struct IconManager {
    var dark: Bool
    init(dark: Bool) {
        self.dark = dark
        self.switchIcon()
    }
    
    private func switchIcon() {
        if #available(iOS 13.0, *), self.shouldSwitchIcon() {
            let icon: String? = self.dark ? "mashina_dark" : nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // без этого возвращается ошибка "Operation cancelled"
                UIApplication.shared.setAlternateIconName(icon)
            }
            UserDefaults.standard.set(self.dark, forKey: K.UD.darkTheme)
        }
    }
    
    private func shouldSwitchIcon() -> Bool {
        let wasDarkTheme = UserDefaults.standard.bool(forKey: K.UD.darkTheme)
        return wasDarkTheme != self.dark
    }
}
