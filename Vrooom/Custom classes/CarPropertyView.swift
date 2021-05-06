//
//  CarPropertyView.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class CarPropertyView: UIView, UITextFieldDelegate {
    
    var type: PropertyType
    func setValue(_ text: String) {
        self.valueElement?.setValue(text)
    }
    func readValue() -> String {
        return self.valueElement?.readValue() ?? ""
    }
    
    private var editable: Bool
    private var valueElement: ValueElement?
    
    required init?(coder aDecoder: NSCoder,
                   type: PropertyType,
                   editable: Bool) {
        self.type = type
        self.editable = editable
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect,
         type: PropertyType,
         editable: Bool) {
        self.type = type
        self.editable = editable
        super.init(frame: frame)
        self.viewSetup(frame: frame)
    }
    
    private func viewSetup(frame: CGRect) {
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        let nameLabel = UILabel()
        nameLabel.font = FontManager.texGyreBold(size: 14)
        nameLabel.textColor = FontManager.blueAndWhite
        nameLabel.text = self.type.getName()
        let valueElement: ValueElement = self.editable ?
            self.createValueTextField() :
            self.createValueLabel()
        let valueElementAsView = valueElement as? UIView ?? UIView()
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueElementAsView)
        
        self.valueElement = valueElement
        self.addSubview(stackView)
        
        stackView.frame = frame
    }
    
    private func createValueLabel() -> ValueElement {
        let label = UILabel()
        let font = FontManager.texGyreRegular(size: 16)
        label.font = font
        label.textColor = FontManager.labelColor
        return label as ValueElement
    }
    
    private func createValueTextField() -> ValueElement {
        let textField = UnderLineTextField(frame: CGRect())
        textField.placeholder = self.type.getPlaceholderValue()
        textField.sendActions(for: .editingChanged)
        return textField as ValueElement
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
