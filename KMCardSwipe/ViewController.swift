//
//  ViewController.swift
//  KCCardSwipe
//
//  Created by Khemmachart Chutapetch on 8/12/2559 BE.
//  Copyright © 2559 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var cView: UIView!
    
    var defaultHeightMin: CGFloat!
    var defaultHeightMax: CGFloat!
    
    var defaultWidthMin: CGFloat!
    var defaultWidthMax: CGFloat!
    
    var card: [UIView] = []
    var currentIndex = -1
    
    override func viewDidLoad() {
        self.card.append(aView)
        self.card.append(bView)
        self.card.append(cView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setDefaultProperties()
        self.setViewProperties()
        self.animateCard(atIndex: 0)
    }
    
    func setViewProperties() {
        for view in self.card {
            let interfaceView = view.subviews[0]
            interfaceView.layer.cornerRadius = 8
        }
    }
    
    func setDefaultProperties() {
        self.defaultWidthMax = self.scrollView.frame.width * 1.00
        self.defaultWidthMin = self.scrollView.frame.width * 0.925
        
        self.defaultHeightMax = self.scrollView.frame.height * 0.95
        self.defaultHeightMin = self.scrollView.frame.height * 0.70
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func next(view view: UIView) {
        let height = CABasicAnimation(keyPath: "bounds.size.height")
        height.fromValue = view.layer.bounds.height
        height.toValue   = defaultHeightMax
        
        let width = CABasicAnimation(keyPath: "bounds.size.width")
        width.fromValue = view.layer.bounds.width
        width.toValue   = defaultWidthMax
        
        let groupAnimation =  CAAnimationGroup()
        groupAnimation.animations = [height, width]
        groupAnimation.removedOnCompletion = true
        groupAnimation.duration = 0
        groupAnimation.repeatCount = 1
        
        view.layer.addAnimation(groupAnimation, forKey: nil)
        view.layer.bounds.size.height = defaultHeightMax
        view.layer.bounds.size.width = defaultWidthMax
    }
    
    func previous(view view: UIView) {
        let height = CABasicAnimation(keyPath: "bounds.size.height")
        height.fromValue = view.layer.bounds.height
        height.toValue   = defaultHeightMin
        
        let width = CABasicAnimation(keyPath: "bounds.size.width")
        width.fromValue = view.layer.bounds.width
        width.toValue   = defaultWidthMin
        
        let groupAnimation =  CAAnimationGroup()
        groupAnimation.animations = [height, width]
        groupAnimation.removedOnCompletion = true
        groupAnimation.duration = 0
        groupAnimation.repeatCount = 1
        
        view.layer.addAnimation(groupAnimation, forKey: nil)
        view.layer.bounds.size.height = defaultHeightMin
        view.layer.bounds.size.width = defaultWidthMin
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let cardWidth = scrollView.frame.size.width;
        let fractionalCard = scrollView.contentOffset.x / cardWidth;
        let cardIndex = lround(Double(fractionalCard));
        
        self.animateCard(atIndex: cardIndex)
    }
    
    func animateCard(atIndex cardIndex: Int) {
        if (self.currentIndex != cardIndex) {
            self.currentIndex = cardIndex
            for (index, view) in self.card.enumerate() {
                if index == cardIndex {
                    self.next(view: view.subviews[0])
                } else {
                    self.previous(view: view.subviews[0])
                }
            }
        }
    }
}

