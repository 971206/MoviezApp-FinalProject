//
//  ButtonAnimation.swift
//  Moviez
//
//  Created by Eka Altunashvili  on 17.07.21.
//

import UIKit

class ButtonAnimationView: UIView {
    // MARK: - IBInspectables
    @IBInspectable var textSize: CGFloat = 0
    @IBInspectable var buttonHeight: CGFloat = 0
    @IBInspectable var fontName: String = "Helvetica Neue Medium Extended"
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icShoppingCart24Px"), for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: textSize)
        button.setTitle("Damateba", for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checked-orange"), for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: textSize)
        button.setTitle("Damatebulia", for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = false
        button.alpha = 0
        return button
    }()
    
    
    var firstConstraint: NSLayoutConstraint?
    var secondConstraint: NSLayoutConstraint?
    fileprivate var firstLoad = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if firstLoad {
            configure()
            firstLoad = false
        }
    }
    
    func configure() {
        self.backgroundColor = .lightText
        createAddButton()
    }
    private func createAddButton() {
        self.addSubview(addButton)
        self.addSubview(doneButton)
        
        doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        secondConstraint = doneButton.centerYAnchor.constraint(equalTo: self.bottomAnchor)
        secondConstraint?.isActive = true
        
        addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        firstConstraint = addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        firstConstraint?.isActive = true
    }
    
    func makeAnimation(){
        UIView.animate(withDuration: 0.5) {
            self.addButton.isUserInteractionEnabled = false
            self.addButton.isEnabled = false
            self.doneButton.alpha = 1
            self.addButton.alpha = 0
            self.firstConstraint?.constant = -(self.frame.height / 2)
            self.secondConstraint?.constant = -(self.frame.height / 2)
            self.layoutIfNeeded()
        } completion: { completed in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.5) {
                    self.doneButton.alpha = 0
                    self.addButton.alpha = 1
                    self.firstConstraint?.constant = 0
                    self.secondConstraint?.constant = 0
                    self.addButton.isUserInteractionEnabled = true
                    self.addButton.isEnabled = true
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
}
