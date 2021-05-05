//
//  PopUpView.swift
//  Vrooom
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

final class PopUpView: UIView {
    
    let animationDuration = 0.3
    
    init(text: String,
         parentView: UIView) {
        super.init(frame: UIScreen.main.bounds)
        self.alpha = 0
        self.addBlur()
        self.setupLabel(text)
        parentView.addSubview(self)
        self.present()
    }
    
    private func present() {
        self.isHidden = false
        UIView.animate(withDuration: self.animationDuration) {
            self.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.dissapear()
        }
    }
    
    private func dissapear() {
        UIView.animate(withDuration: self.animationDuration) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
    
    private func addBlur() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
