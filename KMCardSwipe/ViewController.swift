//
//  ViewController.swift
//  KCCardSwipe
//
//  Created by Khemmachart Chutapetch on 8/12/2559 BE.
//  Copyright © 2559 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: KMScrollView!
    
    var card: [KMCardView] = []
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        let cardView1 = KMCardView(frame: self.view.frame)
        let cardView2 = KMCardView(frame: self.view.frame)
        
        self.scrollView.addCardViews([cardView1, cardView2])
        // self.scrollView.enableAutoScrolling(3)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    // UISrollView delegate
    
    
}

