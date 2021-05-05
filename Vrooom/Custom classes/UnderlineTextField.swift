//
//  UnderlineTextField.swift
//  Vrooom
//
//  Created by Admin on 18.09.2020.
//  Copyright © 2020 Rudenko. All rights reserved.
//

import UIKit

class UnderLineTextField: UITextField , UITextFieldDelegate { //adds an underline to a textField

    private var line: CALayer?
    private let lineWidth: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addUnderLine()
        self.setupFont()
        self.addUnderLine()
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChange() {
        self.redrawUnderLine()
    }
    
    private func redrawUnderLine() {
        let size: CGSize
        if let font = self.font,
           let text = self.textToOperate() {
            size = text.sizeOfString(usingFont: font)
        } else {
            size = CGSize(width: self.frame.width, height: self.frame.height)
        }
        let frame = CGRect(x: 0,
                           y: size.height - self.lineWidth,
                           width: size.width,
                           height: lineWidth)
        self.line?.frame = frame
    }
    
    private func addUnderLine() {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        self.line = bottomLine
    }
    
    private func setupFont() {
        self.font = FontManager.texGyreRegular(size: 16)
    }
    
    private func textToOperate() -> String? {
        guard let text = self.text,
              !text.isEmpty else {
            return self.placeholder
        }
        return text
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
