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
    @IBInspectable var fontName: String = "Sarabun-Medium.ttf"
    @IBInspectable var addButtonText: String = ""
    @IBInspectable var doneButtonText: String = ""
    @IBInspectable var addButtonImageTitle: String = ""
    @IBInspectable var doneButtonImageTitle: String = ""
    
    
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: addButtonImageTitle), for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: textSize)
        button.setTitle(addButtonText, for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: doneButtonImageTitle), for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: textSize)
        button.setTitle(doneButtonText, for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
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
        }
    }
    
}
