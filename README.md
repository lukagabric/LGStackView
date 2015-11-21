# LGStackView

LGStackView is a control written in Swift, similar to UIStackView for iOS 8+.

The subviews constrained with autolayout constraints in Interface Builder are stacked based on their hidden or alpha property and ordered by their z index, which is set by reordering subviews list in Interface Builder. Once the constraints are set up for all views, there are two IBInspectable properties in Interface Builder to set up. First is the orientation (vertical/horizontal), and the seconds is padding among views.

Once the hidden or alpha property is changed, invalidateLayout method should be called to arrange constraints. Only horizontal/vertical constraints between views are modified. Constraints change can be animated:

    UIView.animateWithDuration(1) {
        self.someSubview.alpha = 0
        self.stackView.invalidateLayout()
        self.view.layoutIfNeeded()
    }

[![LGLinearFlow](http://lukagabric.com/wp-content/uploads/2015/11/lgstackview-youtube.png)](https://www.youtube.com/watch?v=q-NAK6fN7pk)
