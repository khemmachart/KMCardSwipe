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
    
    @IBOutlet weak var aView: KMCardView!
    @IBOutlet weak var bView: KMCardView!
    @IBOutlet weak var cView: KMCardView!
    
    var card: [KMCardView] = []
    var currentIndex = -1
    
    var timer: NSTimer?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        self.card.append(aView)
        self.card.append(bView)
        self.card.append(cView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setViewProperties()
        self.animateCard(atIndex: 0)
        
        self.enableAutoScrolling(4)
    }
    
    func setViewProperties() {
        self.view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.subviews[0].backgroundColor = UIColor.clearColor()
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
                    self.animateCurrent(view: view)
                } else {
                    self.animateOther(view: view)
                }
            }
        }
    }
    
    // Animate card
    
    func animateCurrent(view view: KMCardView) {
        view.animate(isCurrentView: true)
    }
    
    func animateOther(view view: KMCardView) {
        view.animate(isCurrentView: false)
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
        self.scrollToCard(currentIndex)
    }
    
    func increaseCounter() {
        if currentIndex == self.card.count {
            self.currentIndex = 0
        } else {
            self.currentIndex += 1
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

