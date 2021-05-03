//
//  CarPropertyView.swift
//  Vrooom
//
//  Created by Admin on 03.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class CarPropertyView: UIView {
    
    var type: PropertyViewType
    func setValue(_ text: String) {
        self.valueElement?.setValue(text)
    }
    func readValue() -> String {
        return self.valueElement?.readValue() ?? ""
    }
    
    private var valueElement: ValueElement?
    
    required init?(coder aDecoder: NSCoder,
                   type: PropertyViewType) {
        self.type = type
        super.init(coder: aDecoder)
    }
    
    init(type: PropertyViewType) {
        self.type = type
        super.init(frame: CGRect())
        self.viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewSetup() {
        let stackView = UIStackView.init(frame: self.frame)
        stackView.axis = .vertical
        
        let nameLabel = UILabel()
        let fontSize: CGFloat = 17
        let font = UIFont.init(name: "TeXGyreAdventor-Regular", size: fontSize) ??
            UIFont.systemFont(ofSize: fontSize)
        nameLabel.font = font
        nameLabel.textColor = #colorLiteral(red: 0, green: 0.1294117647, blue: 1, alpha: 1)
        
        let valueElement: ValueElement = self.type == .editable ?
            self.createValueTextField() :
            self.createValueLabel()
        let valueElementAsView = valueElement as? UIView ?? UIView()
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueElementAsView)
        
        self.addSubview(stackView)
    }
    
    private func createValueLabel() -> UILabel {
        let label = UILabel()
        let fontSize: CGFloat = 20
        let font = UIFont.init(name: "TeXGyreAdventor-Regular", size: fontSize) ??
            UIFont.systemFont(ofSize: fontSize)
        label.font = font
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }
    
    private func createValueTextField() -> UnderLineTextField {
        let textField = UnderLineTextField(frame: CGRect())
        return textField
    }
}
