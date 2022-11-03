//
//  UIView + Extension.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import UIKit

public extension UIView {
    typealias Constraints = [NSLayoutConstraint]
    func constrain(_ constraint: Constraints) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraint)
    }
    
    // MARK: Main Methods
    @discardableResult
    func constrainLeftToRight(of view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = left(to: view, anchor: view.rightAnchor, constant: constant)
        constrain(constraints)

        return constraints
    }

    @discardableResult
    func constrainRightToLeft(of view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = right(to: view, anchor: view.leftAnchor, constant: constant)
        constrain(constraints)

        return constraints
    }
    
    @discardableResult
    func constrainToSuperview(insets: UIEdgeInsets = .zero) -> Constraints {
        let constraints = constraintsForEdges(to: superview!, insets: insets)
        constrain(constraints)
        return constraints
    }

    @discardableResult
    func constrainToSuperview(padding: CGFloat = 0) -> Constraints {
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let constraints = constraintsForEdges(to: superview!, insets: insets)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainVerticalEdges(to view: UIView, topPadding: CGFloat = 0, bottomPadding: CGFloat = 0) -> Constraints {
        let constraints = constraintsForVerticalEdges(to: view, padding: .init(top: topPadding, left: 0, bottom: bottomPadding, right: 0))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainHorizontalEdges(to view: UIView, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> Constraints {
        let constraints = constraintsForHorizontalEdges(to: view, padding: .init(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainHeight(_ height: CGFloat) -> Constraints {
        let constraints = constraintsForHeight(height)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainWidth(_ width: CGFloat) -> Constraints {
        let constraints = constraintsForWidth(width)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainSize(_ size: CGSize) -> Constraints {
        let constraints = constraintsForSize(size: size)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainSize(width: CGFloat, height: CGFloat) -> Constraints {
        let constraints = constraintsForSize(size: CGSize(width: width, height: height))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func contraintCenterToSuperview() -> Constraints {
        var constraints = centerX(to: superview!)
        constraints.append(contentsOf: centerY(to: superview!))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainCenter(to view: UIView, xOffset: CGFloat = 0) -> Constraints {
        var constraints = centerX(to: view, constant: xOffset)
        constraints.append(contentsOf: centerY(to: view))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainCenterX(to view: UIView, offset: Int = 0) -> Constraints {
        let constraints = centerX(to: view, constant: CGFloat(offset))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainCenterY(to view: UIView, offset: Int = 0) -> Constraints {
        let constraints = centerY(to: view, constant: CGFloat(offset))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func pinToEdge(to view: UIView, constant: CGFloat) -> Constraints {
        let constraints = pinToEdges(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTopRight(to view: UIView, topPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> Constraints {
        var constraints = top(to: view, constant: topPadding)
        constraints.append(contentsOf: right(to: view, constant: rightPadding))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTopLeft(to view: UIView, topPadding: CGFloat = 0, leftPadding: CGFloat = 0) -> Constraints {
        var constraints = top(to: view, constant: topPadding)
        constraints.append(contentsOf: left(to: view, constant: leftPadding))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottomRight(to view: UIView, bottomPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> Constraints {
        var constraints = bottom(to: view, constant: bottomPadding)
        constraints.append(contentsOf: right(to: view, constant: rightPadding))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottomLeft(to view: UIView, bottomPadding: CGFloat = 0, leftPadding: CGFloat = 0) -> Constraints {
        var constraints = bottom(to: view, constant: bottomPadding)
        constraints.append(contentsOf: left(to: view, constant: leftPadding))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainLeft(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = left(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainRight(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = right(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottom(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = bottom(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottomSafeArea(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = bottomSafeArea(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTop(to view: UIView,  constant: CGFloat = 0) -> Constraints {
        let constraints = top(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTopSafeArea(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = topSafeArea(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTopToBottom(of view: UIView,  constant: CGFloat = 0) -> Constraints {
        let constraints = topToBottom(of: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottomToTop(of view: UIView,  constant: CGFloat = 0) -> Constraints {
        let constraints = bottomToTop(of: view, constant: constant)
        constrain(constraints)
        return constraints
    }
}

// MARK: Building Blocks

private extension UIView {

    func constraintsForHeight(_ height: CGFloat) -> Constraints {
        return [
            heightAnchor.constraint(equalToConstant: height),
        ]
    }

    func constraintsForWidth(_ width: CGFloat) -> Constraints {
        return [
            widthAnchor.constraint(equalToConstant: width),
        ]
    }
    
    func constraintsForSize(size: CGSize) -> Constraints {
        return [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ]
    }
    
    func constraintsForEdges(to view: UIView, insets: UIEdgeInsets) -> Constraints {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
        ]
    }
    
    func pinToEdges(to view: UIView, constant: CGFloat = 0) -> Constraints {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }
    
    func constraintsForHorizontalEdges(to view: UIView, padding: UIEdgeInsets) -> Constraints {
        return [leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left), trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right)]
    }
    
    func constraintsForVerticalEdges(to view: UIView, padding: UIEdgeInsets) -> Constraints {
        return [topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top), bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)]
    }
    
    func centerX(to view: UIView, constant: CGFloat = 0) -> Constraints {
        return [centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)]
    }
    
    func centerY(to view: UIView, constant: CGFloat = 0) -> Constraints {
        return [centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)]
    }
    
    func top(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: constant)]
    }
    
    func topSafeArea(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [topAnchor.constraint(equalTo: anchor ?? view.safeAreaLayoutGuide.topAnchor, constant: constant)]
    }
    
    func bottom(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: constant)]
    }
    
    func bottomSafeArea(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [bottomAnchor.constraint(equalTo: anchor ?? view.safeAreaLayoutGuide.bottomAnchor, constant: constant)]
    }
    
    func right(to view: UIView, anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [rightAnchor.constraint(equalTo: anchor ?? view.rightAnchor, constant: constant)]
    }
    
    func left(to view: UIView, anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [leftAnchor.constraint(equalTo: anchor ?? view.leftAnchor, constant: constant)]
    }
    
    func topToBottom(of view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [topAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: constant)]
    }
    
    func bottomToTop(of view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [bottomAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: constant)]
    }
}

// Second
public extension UIView {
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    func fixInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

// Third
public struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

public extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}

public extension UIView {
    //add a tap gesture fuction to ui view
    func addTapGesture(tapNumber: Int = 1, target: Any, action: Selector) {
        //create gesture recognizer
        let tap = UITapGestureRecognizer(target: target, action: action)
        //set number of count
        tap.numberOfTapsRequired = tapNumber
        //add gesture to view
        addGestureRecognizer(tap)
        // set the user interaction
        isUserInteractionEnabled = true
    }
    
    func addSubview(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func addSubview(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
