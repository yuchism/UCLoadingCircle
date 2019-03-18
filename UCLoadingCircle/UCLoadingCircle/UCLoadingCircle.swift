//
//  UCLoadingCircle.swift
//  UCLoadingCircle
//
//  Created by yuch on 18/3/19.
//  Copyright © 2019 Yuch. All rights reserved.
//

import UIKit

@IBDesignable
class UCLoadingCircle:UIView {
    
    private var backgroundLayer:CAShapeLayer = CAShapeLayer()
    private var animationLayer:CAShapeLayer = CAShapeLayer()
    
    @IBInspectable
    var lineWidth:CGFloat = 5
    
    @IBInspectable
    var loadingBackgroundColor:UIColor = .lightGray
    
    @IBInspectable
    var loadingForegroundColor:UIColor = .cyan

    @IBInspectable
    var animationSpeed:Double = 0.5
    
    @IBInspectable
    var animation:Bool = true {
        didSet {
            if animation == true {
                self.startAnimation()
            } else {
                self.stopAnimation()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.animation = true
        self.drawBackgroundLayer()
        self.drawAnimationLayer()
    }
    
    private var radius: CGFloat {
        get{
            let radius = (min(self.frame.height, self.frame.width) - lineWidth) / 2
            return radius
        }
    }
    
    private var currentCenter:CGPoint {
        get {
            return self.convert(self.center, from: self.superview)
        }
    }
    
    func startAnimation() {
        DispatchQueue.main.async {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = CGFloat.pi * -0.5
            rotationAnimation.toValue = CGFloat.pi * 1.5
            rotationAnimation.duration = self.animationSpeed
            rotationAnimation.repeatCount = .infinity
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            
            self.animationLayer.add(rotationAnimation, forKey: "rotate_animation")
        }
    }
    
    func stopAnimation() {
        DispatchQueue.main.async {
            self.animationLayer.removeAllAnimations()
        }
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: self.currentCenter, radius: self.radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = self.loadingBackgroundColor.cgColor
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20 / 100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(backgroundLayer)
    }
    
    private func drawAnimationLayer(){
        let start:CGFloat = 0
        let end = CGFloat.pi * 1/3
        
        let path = UIBezierPath(arcCenter: self.currentCenter, radius: self.radius, startAngle: start, endAngle: end, clockwise: true)
        
        self.animationLayer.path = path.cgPath
        self.animationLayer.strokeColor = self.loadingForegroundColor.cgColor
        self.animationLayer.lineWidth = lineWidth - (lineWidth * 20 / 100)
        self.animationLayer.fillColor = UIColor.clear.cgColor
        self.animationLayer.lineCap = CAShapeLayerLineCap.round
        self.animationLayer.position = self.currentCenter
        self.animationLayer.bounds = self.bounds
        self.layer.addSublayer(animationLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.drawBackgroundLayer()
        self.drawAnimationLayer()
    }
}
