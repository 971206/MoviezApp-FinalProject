//
//  UIView + Extension.swift
//  Moviez
//
//  Created by MacBook  on 05.06.21.
//

import UIKit
import NVActivityIndicatorView

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView {
    func startLoading(){
        stopLoading()
        let loader = NVActivityIndicatorView(frame: .zero, type: .ballPulseSync, color: .white, padding: 0)
        loader.tag = 303
        loader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 40),
            loader.heightAnchor.constraint(equalToConstant: 40),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        loader.startAnimating()
    }
    
    func stopLoading(){
        self.viewWithTag(303)?.removeFromSuperview()
    }
}
