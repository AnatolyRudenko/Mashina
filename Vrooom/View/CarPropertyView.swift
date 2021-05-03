//
//  CarPropertyView.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class CarPropertyView: UIView, UITextFieldDelegate {
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewSetup(frame: CGRect) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red
//        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.font = FontManager.texGyreRegular(size: 17)
        nameLabel.textColor = #colorLiteral(red: 0, green: 0.1294117647, blue: 1, alpha: 1)
        nameLabel.text = self.type.getName()
        nameLabel.backgroundColor = .blue
//        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let valueElement: ValueElement = self.editable ?
            self.createValueTextField() :
            self.createValueLabel()
        let valueElementAsView = valueElement as? UIView ?? UIView()
//        valueElementAsView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        valueElementAsView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueElementAsView)
        stackView.layoutIfNeeded()
        
        self.valueElement = valueElement
        self.addSubview(stackView)
        self.layoutIfNeeded()
        
        stackView.frame = frame
    }
    
    private func createValueLabel() -> ValueElement {
        let label = UILabel()
        let font = FontManager.texGyreRegular(size: 20)
        label.font = font
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label as ValueElement
    }
    
    private func createValueTextField() -> ValueElement {
        let textField = UnderLineTextField(frame: CGRect())
//        textField.delegate = parent
        textField.placeholder = self.type.getPlaceholderValue()
        return textField as ValueElement
    }
}
