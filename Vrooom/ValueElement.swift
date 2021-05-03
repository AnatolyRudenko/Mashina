//
//  ValueElement protocol.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

protocol ValueElement {
    func setValue(_ text: String)
    func readValue() -> String
}

extension UnderLineTextField: ValueElement {
    func setValue(_ text: String) {
        self.text = text
    }
    func readValue() -> String {
        return self.text ?? ""
    }
}

extension UILabel: ValueElement {
    func setValue(_ text: String) {
        self.text = text
    }
    func readValue() -> String {
        return self.text ?? ""
    }
}
