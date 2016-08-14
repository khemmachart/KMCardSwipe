//
//  KMCardView.swift
//  KMCardSwipe
//
//  Created by Khemmachart Chutapetch on 8/14/2559 BE.
//  Copyright © 2559 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class KMCardView: UIView {
    
    var defaultHeightMin : CGFloat = 0
    var defaultHeightMax : CGFloat = 0
    
    var defaultWidthMin  : CGFloat = 0
    var defaultWidthMax  : CGFloat = 0
    
    @IBOutlet var interfaceView: UIView!
    
    override func layoutSubviews() {
        self.addInterfaceView()
        self.setDefaultProperties()
    }
    
    func animate(isCurrentView isCurrentView: Bool) {
        let height = CABasicAnimation(keyPath: "bounds.size.height")
        height.fromValue = self.interfaceView.layer.bounds.height
        height.toValue   = isCurrentView ? defaultHeightMax :defaultHeightMin
        
        let width = CABasicAnimation(keyPath: "bounds.size.width")
        width.fromValue = self.interfaceView.layer.bounds.width
        width.toValue   = isCurrentView ? defaultWidthMax : defaultWidthMin
        
        let groupAnimation =  CAAnimationGroup()
        groupAnimation.animations = [height, width]
        groupAnimation.removedOnCompletion = true
        groupAnimation.duration = 0
        groupAnimation.repeatCount = 1
        
        self.interfaceView.layer.addAnimation(groupAnimation, forKey: nil)
        self.interfaceView.layer.bounds.size.height = isCurrentView ? defaultHeightMax : defaultHeightMin
        self.interfaceView.layer.bounds.size.width = isCurrentView ? defaultWidthMax : defaultWidthMin
    }
    
    func setDefaultProperties() {
        self.defaultWidthMax  = self.frame.width  * 1.00
        self.defaultWidthMin  = self.frame.width  * 0.925
        self.defaultHeightMax = self.frame.height * 1.00
        self.defaultHeightMin = self.frame.height * 0.75
    }
    
    func addInterfaceView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).CGColor
        let backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        interfaceView.layer.cornerRadius = 8
        interfaceView.layer.borderColor = borderColor
        interfaceView.layer.borderWidth = 1
        interfaceView.backgroundColor = backgroundColor
    }
}
