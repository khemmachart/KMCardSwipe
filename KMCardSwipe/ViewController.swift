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
    
    var previousPage = 0
    var currentIndex = 0
    
    override func viewDidLoad() {
        self.card.append(aView)
        self.card.append(bView)
        self.card.append(cView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.defaultWidthMax = self.scrollView.frame.width * 1.00
        self.defaultWidthMin = self.scrollView.frame.width * 0.925
        
        self.defaultHeightMax = self.scrollView.frame.height * 0.95
        self.defaultHeightMin = self.scrollView.frame.height * 0.70
        
        for (index, view) in self.card.enumerate() {
            if index == 0 {
                let interfaceView = view.subviews[0]
                interfaceView.layer.cornerRadius = 8
                self.next(view: interfaceView)
            } else {
                let interfaceView = view.subviews[0]
                interfaceView.layer.cornerRadius = 8
                self.previous(view: interfaceView)
            }
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func overCheckPoint(xPosition: CGFloat) -> Bool {
        let currentCardPosition = abs(xPosition - CGFloat(currentIndex) * self.scrollView.frame.width)
        let checkPoint = self.scrollView.frame.width * 0.5
        
        return currentCardPosition > checkPoint
    }
    
    func reachEdge(index: Int) -> Bool {
        let indexOutOfBounds = index < 0 || index == self.card.count
        let currentIndexOutOfBound = currentIndex < 0 || currentIndex == self.card.count
        
        return indexOutOfBounds || currentIndexOutOfBound
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        let xPosition = scrollView.contentOffset.x
//        let isForward = xPosition/scrollView.frame.width > CGFloat(self.currentIndex)
//        let index = isForward ? currentIndex + 1 : currentIndex - 1
//        
//        if (!overCheckPoint(xPosition) || reachEdge(index)) {
//            return
//        }
//        
//        self.previous(view: self.card[currentIndex].subviews[0])
//        self.next(view: self.card[index].subviews[0])
        
        
        
//        let xPosition = scrollView.contentOffset.x + scrollView.frame.width/2
//        let pageIndex = Int(xPosition/scrollView.frame.width)
//        self.currentIndex = pageIndex
//        print(pageIndex)
//        
//        for (index, view) in self.card.enumerate() {
//            if index == pageIndex {
//                self.next(view: view.subviews[0])
//            } else {
//                self.previous(view: view.subviews[0])
//            }
//        }
    }
    
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
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width;
        let fractionalPage = scrollView.contentOffset.x / pageWidth;
        let page = lround(Double(fractionalPage));
        print(page)
        
//        if (previousPage != page) {
//            // Page has changed, do your thing!
//            // ...
//            // Finally, update previous page
//            previousPage = page
//        }
        
        if (self.currentIndex != page) {
            currentIndex = page
            for (index, view) in self.card.enumerate() {
                if index == page {
                    self.next(view: view.subviews[0])
                } else {
                    self.previous(view: view.subviews[0])
                }
            }
        }
    }
}

