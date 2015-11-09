//
//  ViewController.swift
//  LGStackView
//
//  Created by Luka Gabric on 09/11/15.
//  Copyright © 2015 Luka Gabric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var horizontalStackView: LGStackView!
    @IBOutlet weak var horizontalView1: UIView!
    @IBOutlet weak var horizontalView2: UIView!
    @IBOutlet weak var horizontalView3: UIView!

    @IBOutlet weak var verticalStackView: LGStackView!
    @IBOutlet weak var verticalView1: UIView!
    @IBOutlet weak var verticalView2: UIView!
    @IBOutlet weak var verticalView3: UIView!
    
    var timer: NSTimer!
    var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.views = [self.horizontalView1, self.horizontalView2, self.horizontalView3, self.verticalView1, self.verticalView2, self.verticalView3]
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "timerFired", userInfo: nil, repeats: true)
    }
    
    func timerFired() {
        UIView.animateWithDuration(1) {
            for view in self.views {
                view.alpha = CGFloat(arc4random_uniform(2))
            }

            self.horizontalStackView.invalidateLayout()
            self.verticalStackView.invalidateLayout()
            self.view.layoutIfNeeded()
        }
    }

}
