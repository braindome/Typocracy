//
//  GradientBackground.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-30.
//

import UIKit

extension UIView {
    
    func addGradientBackground(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
