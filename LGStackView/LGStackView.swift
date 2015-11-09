//
//  LGStackView.swift
//  LGStackView
//
//  Created by Luka Gabric on 09/11/15.
//  Copyright © 2015 Luka Gabric. All rights reserved.
//

import UIKit

public class LGStackView: UIView {
    
    //MARK: - Vars
    
    @IBInspectable var verticalLayout: Bool = false
    @IBInspectable var padding: CGFloat = 0

    //MARK: - Override
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.invalidateLayout()
    }
    
    //MARK: - Public
    
    public func invalidateLayout() {
        var visibleViews = [UIView]()
        var hiddenViews = [UIView]()
        
        for subview in self.subviews {
            if subview.hidden || subview.alpha < 1 {
                hiddenViews.append(subview)
            }
            else {
                visibleViews.append(subview)
            }
        }

        self.removeCurrentConstraints()
        self.layoutVisibleViews(visibleViews)
        self.layoutHiddenViews(hiddenViews)
    }
    
    //MARK: - Remove Constraints
    
    func removeCurrentConstraints() {
        for subview in self.subviews {
            self.removeConstraintsForView(subview)
        }
    }
    
    func removeConstraintsForView(view: UIView) {
        var constraintsToRemove = [NSLayoutConstraint]()
        
        for constraint in constraints {
            if constraint.firstItem as? UIView == view || constraint.secondItem as? UIView == view {
                if self.verticalLayout {
                    if self.isVerticalConstraint(constraint) {
                        constraintsToRemove.append(constraint)
                    }
                }
                else {
                    if self.isHorizontalConstraint(constraint) {
                        constraintsToRemove.append(constraint)
                    }
                }
            }
        }
        
        self.removeConstraints(constraintsToRemove)
    }
    
    func isVerticalConstraint(constraint: NSLayoutConstraint) -> Bool {
        return isVerticalAttribute(constraint.firstAttribute) || isVerticalAttribute(constraint.secondAttribute)
    }
    
    func isVerticalAttribute(attribute: NSLayoutAttribute) -> Bool {
        let verticalAttributes: [NSLayoutAttribute] = [.Top, .TopMargin, .Bottom, .BottomMargin]
        return verticalAttributes.contains(attribute)
    }
    
    func isHorizontalConstraint(constraint: NSLayoutConstraint) -> Bool {
        return isHorizontalAttribute(constraint.firstAttribute) || isHorizontalAttribute(constraint.secondAttribute)
    }

    func isHorizontalAttribute(attribute: NSLayoutAttribute) -> Bool {
        let horizontalAttributes: [NSLayoutAttribute] = [.Leading, .LeadingMargin, .Trailing, .TrailingMargin, .Left, .LeftMargin, .Right, .RightMargin]
        return horizontalAttributes.contains(attribute)
    }

    //MARK: - Layout Views
    
    //MARK: Visible
    
    func layoutVisibleViews(views: [UIView]) {
        if self.verticalLayout {
            self.verticallyLayoutVisibleViews(views)
        }
        else {
            self.horizontallyLayoutVisibleViews(views)
        }
    }
    
    func verticallyLayoutVisibleViews(visibleViews: [UIView]) {
        for (index, view) in visibleViews.enumerate() {
            let topView = index == 0 ? self : visibleViews[index - 1]
            let topViewAttribute: NSLayoutAttribute = index == 0 ? .Top : .Bottom
            let topViewOffset = index == 0 ? 0 : self.padding
            
            let topConstraint = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: topView, attribute: topViewAttribute, multiplier: 1, constant: topViewOffset)
            self.addConstraint(topConstraint)
            
            if (index == visibleViews.endIndex - 1) {
                let bottomConstraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
                self.addConstraint(bottomConstraint)
            }
            
        }
    }
    
    func horizontallyLayoutVisibleViews(visibleViews: [UIView]) {
        for (index, view) in visibleViews.enumerate() {
            let leftView = index == 0 ? self : visibleViews[index - 1]
            let leftViewAttribute: NSLayoutAttribute = index == 0 ? .Leading : .Trailing
            let leftViewOffset = index == 0 ? 0 : self.padding

            let leftConstraint = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: leftView, attribute: leftViewAttribute, multiplier: 1, constant: leftViewOffset)
            self.addConstraint(leftConstraint)

            if (index == visibleViews.endIndex - 1) {
                let rightConstraint = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
                self.addConstraint(rightConstraint)
            }
            
        }
    }
    
    //MARK: Hidden

    func layoutHiddenViews(views: [UIView]) {
        if self.verticalLayout {
            self.verticallyLayoutHiddenViews(views)
        }
        else {
            self.horizontallyLayoutHiddenViews(views)
        }
    }
    
    func verticallyLayoutHiddenViews(hiddenViews: [UIView]) {
        for view in hiddenViews {
            let index = self.subviews.indexOf(view)!
            let topView = index == 0 ? self : self.subviews[index - 1]
            
            let topViewAttribute: NSLayoutAttribute = topView == self ? .Top : .Bottom
            let topViewOffset = topView == self ? 0 : self.padding

            let topConstraint = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: topView, attribute: topViewAttribute, multiplier: 1, constant: topViewOffset)
            self.addConstraint(topConstraint)
        }
    }
    
    func horizontallyLayoutHiddenViews(hiddenViews: [UIView]) {
        for view in hiddenViews {
            let index = self.subviews.indexOf(view)!
            let leftView = index == 0 ? self : self.subviews[index - 1]
            
            let leftViewAttribute: NSLayoutAttribute = leftView == self ? .Leading : .Trailing
            let leftViewOffset = leftView == self ? 0 : self.padding
     
            let leftConstraint = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: leftView, attribute: leftViewAttribute, multiplier: 1, constant: leftViewOffset)
            self.addConstraint(leftConstraint)
        }
    }
    
}
