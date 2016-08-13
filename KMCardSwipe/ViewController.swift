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
    
    var timer: NSTimer?
    var counter: Int = 0
    
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
        
        self.enableAutoScrolling(4)
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
    
    // UISrollView delegate
    
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
                    self.animateCurrent(view: view.subviews[0])
                } else {
                    self.animateOther(view: view.subviews[0])
                }
            }
        }
    }
    
    // Animation
    
    func animateCurrent(view view: UIView) {
        self.animateView(view: view, isCurrentView: true)
    }
    
    func animateOther(view view: UIView) {
        self.animateView(view: view, isCurrentView: false)
    }
    
    func animateView(view view: UIView, isCurrentView: Bool) {
        let height = CABasicAnimation(keyPath: "bounds.size.height")
        height.fromValue = view.layer.bounds.height
        height.toValue   = isCurrentView ? defaultHeightMax :defaultHeightMin
        
        let width = CABasicAnimation(keyPath: "bounds.size.width")
        width.fromValue = view.layer.bounds.width
        width.toValue   = isCurrentView ? defaultWidthMax : defaultWidthMin
        
        let groupAnimation =  CAAnimationGroup()
        groupAnimation.animations = [height, width]
        groupAnimation.removedOnCompletion = true
        groupAnimation.duration = 0
        groupAnimation.repeatCount = 1
        
        view.layer.addAnimation(groupAnimation, forKey: nil)
        view.layer.bounds.size.height = isCurrentView ? defaultHeightMax : defaultHeightMin
        view.layer.bounds.size.width = isCurrentView ? defaultWidthMax : defaultWidthMin
    }
    
    // Auto Scrolling
    
    func enableAutoScrolling(delay: Double) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(self.autoScrolling), userInfo: nil, repeats: true)
    }
    
    func disableAutoScrolling() {
        self.timer?.invalidate()
    }
    
    func autoScrolling() {
        self.increaseCounter()
        self.scrollToCard(counter)
    }
    
    func increaseCounter() {
        if counter == self.card.count {
            self.counter = 0
        } else {
            self.counter += 1
        }
    }
    
    // Scrolling
    
    func scrollToCard(index: Int) {
        let width = self.scrollView.frame.width
        let height = self.scrollView.frame.height
        let position = width * CGFloat(index)
        let frame = CGRectMake(position, 0, width, height)
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
}

