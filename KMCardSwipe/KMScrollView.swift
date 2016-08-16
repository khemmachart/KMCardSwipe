//
//  File.swift
//  KMCardSwipe
//
//  Created by Khemmachart Chutapetch on 8/14/2559 BE.
//  Copyright © 2559 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

//class KMScrollView: UIScrollView {
//    
//    @IBOutlet weak var aView: KMCardView!
//    @IBOutlet weak var bView: KMCardView!
//    @IBOutlet weak var cView: KMCardView!
//    
//    @IBOutlet var containerView: UIView!
//    
//    var cardViews: [KMCardView] = []
//    
//    override func awakeFromNib() {
//        self.setViewProperties()
//        self.setCardViews()
//        self.firstAnimation()
//    }
//    
//    func firstAnimation() {
//        self.animateCard(atIndex: 0)
//    }
//    
//    func setCardViews() {
//        self.cardViews.append(aView)
//        self.cardViews.append(bView)
//        self.cardViews.append(cView)
//    }
//    
//    func setViewProperties() {
//        self.backgroundColor = UIColor.clearColor()
//        self.containerView.backgroundColor = UIColor.clearColor()
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        self.delegate?.scrollViewDidScroll!(scrollView)
//        let cardWidth = scrollView.frame.size.width;
//        let fractionalCard = scrollView.contentOffset.x / cardWidth;
//        let cardIndex = lround(Double(fractionalCard));
//        
//        self.animateCard(atIndex: cardIndex)
//    }
//    
//    func animateCard(atIndex cardIndex: Int) {
//        if (self.currentIndex != cardIndex) {
//            self.currentIndex = cardIndex
//            for (index, view) in self.card.enumerate() {
//                if index == cardIndex {
//                    self.animateCurrent(view: view)
//                } else {
//                    self.animateOther(view: view)
//                }
//            }
//        }
//    }
//    
//    // Animate card
//    
//    func animateCurrent(view view: KMCardView) {
//        view.animate(isCurrentView: true)
//    }
//    
//    func animateOther(view view: KMCardView) {
//        view.animate(isCurrentView: false)
//    }
//    
//    // Auto Scrolling
//    
//    func enableAutoScrolling(delay: Double) {
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(self.autoScrolling), userInfo: nil, repeats: true)
//    }
//    
//    func disableAutoScrolling() {
//        self.timer?.invalidate()
//    }
//    
//    func autoScrolling() {
//        self.increaseCounter()
//        self.scrollToCard(currentIndex)
//    }
//    
//    func increaseCounter() {
//        if currentIndex == self.card.count {
//            self.currentIndex = 0
//        } else {
//            self.currentIndex += 1
//        }
//    }
//    
//    // Scrolling
//    
//    func scrollToCard(index: Int) {
//        let width = self.scrollView.frame.width
//        let height = self.scrollView.frame.height
//        let position = width * CGFloat(index)
//        let frame = CGRectMake(position, 0, width, height)
//        self.scrollView.scrollRectToVisible(frame, animated: true)
//    }
//}

import UIKit

protocol KMScrollViewDelegate {
    func testest()
}

class KMScrollView: UIView, UIScrollViewDelegate {
    
    var delegate: KMScrollViewDelegate?
    var scrollView: UIScrollView!
    
    var cards: [KMCardView] = []
    var currentIndex = -1
    
    var timer: NSTimer?

    override func layoutSubviews() {
        self.initScrollView()
    }
    
    func addCardViews(cards: [KMCardView]) {
        self.cards = cards
        self.initContent()
    }
    
    func initScrollView() {
        let frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        self.scrollView = UIScrollView(frame: frame)
        self.scrollView.clipsToBounds = false
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
        self.addSubview(scrollView)
    }
    
    func initContent() {
        
        // Calculate the content size
        let contentWidth  = self.frame.width * CGFloat(self.cards.count)
        let contentHeight = self.frame.height
        self.scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Add cards to the scroll view
        for (index, card) in self.cards.enumerate() {
            card.frame = CGRectMake(CGFloat(index) * self.scrollView.frame.width, 0, self.scrollView.frame.width, self.scrollView.frame.height)
            scrollView.addSubview(card)
            scrollView.layoutIfNeeded()
        }
        
        // Animate the first card
        if (self.cards.count > 0) {
            self.currentIndex = -1
            self.animateCard(atIndex: 0)
        }
    }
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let cardWidth = scrollView.frame.size.width;
        let fractionalCard = scrollView.contentOffset.x / cardWidth;
        let cardIndex = lround(Double(fractionalCard));

        self.animateCard(atIndex: cardIndex)
    }
    
    // MARK: - API
    
    func scrollToCard(index: Int) {
        let width = self.scrollView.frame.width
        let height = self.scrollView.frame.height
        let position = width * CGFloat(index)
        let frame = CGRectMake(position, 0, width, height)
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }

    func enableAutoScrolling(delay: Double) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(KMScrollView.autoScrolling), userInfo: nil, repeats: true)
    }

    func disableAutoScrolling() {
        self.timer?.invalidate()
    }
    
    // MARK: - Scrolling
    
    @objc private func autoScrolling() {
        self.increaseCounter()
        self.scrollToCard(currentIndex)
    }
    
    private func increaseCounter() {
        if currentIndex == self.cards.count {
            self.currentIndex = 0
        } else {
            self.currentIndex += 1
        }
    }
    
    // MARK: - Animation
    
    func animateCard(atIndex cardIndex: Int) {
        if (self.currentIndex != cardIndex) {
            self.currentIndex = cardIndex
            for (index, view) in self.cards.enumerate() {
                if index == cardIndex {
                    self.animateCurrent(view: view)
                } else {
                    self.animateOther(view: view)
                }
            }
        }
    }
    
    func animateCurrent(view view: KMCardView) {
        view.animate(isCurrentView: true)
    }
    
    func animateOther(view view: KMCardView) {
        view.animate(isCurrentView: false)
    }
    
}

