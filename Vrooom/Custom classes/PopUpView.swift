//
//  PopUpView.swift
//  Vrooom
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

class PopUpView: UIView {
    
    init(text: String,
         parentViewSize: CGSize) {
        super.init(frame: CGRect())
        self.alpha = 0
        self.addBlur(parentViewSize)
        self.setupLabel(text)
        self.present()
    }
    
    func present() {
        self.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.dissapear()
        }
    }
    
    private func addBlur(_ parentViewSize: CGSize) {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: parentViewSize.width,
                           height: parentViewSize.height)
        let color: UIColor = .black
        let transparentColor = color.withAlphaComponent(0.6)
        self.backgroundColor = transparentColor
        self.frame = frame
    }
    
    private func setupLabel(_ text: String) {
        let width = self.bounds.width * 0.8
        let height = self.bounds.height * 0.25
        let frame = CGRect(x: (self.bounds.width - width) * 0.5,
                           y: (self.bounds.height - height) * 0.5,
                           width: width,
                           height: height)
        let label = UILabel.init(frame: frame)
        label.adjustsFontSizeToFitWidth = true
        label.font = FontManager.texGyreRegular(size: 22)
        label.textColor = FontManager.customBlue
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        
        self.addSubview(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //to dismiss popUpVIew
        self.dissapear()
    }
    
    private func dissapear() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
