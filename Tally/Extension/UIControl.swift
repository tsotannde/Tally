//
//  UIControl.swift
//  
//
//  Created by Developer on 9/15/25.
//
 import UIKit

// Extension to add tap animation to any UIControl (covers UIButton and ASAuthorizationAppleIDButton)
extension UIControl {
    func addCoolTapFeature(duration: TimeInterval = 0.2, scaleFactor: CGFloat = 0.95) {
        let originalTransform = self.transform
        
        self.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: duration, animations: {
                self.transform = originalTransform.scaledBy(x: scaleFactor, y: scaleFactor)
            })
        }, for: .touchDown)
        
        self.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: duration, animations: {
                self.transform = originalTransform
            })
        }, for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
}


import UIKit
import ObjectiveC

extension UIView {
    func addCoolTapFeature(duration: TimeInterval = 0.2,
                           scaleFactor: CGFloat = 0.95,
                           onTap: (() -> Void)? = nil) {
        let originalTransform = self.transform

        // Enable interaction
        self.isUserInteractionEnabled = true

        // Store closure if provided
        if let onTap = onTap {
            objc_setAssociatedObject(self, &AssociatedKeys.tapActionKey, onTap, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        // Tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)

        // Long press gesture for animation
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePress(_:)))
        self.addGestureRecognizer(pressGesture)

        // Store values so animation can use them
        objc_setAssociatedObject(self, &AssociatedKeys.durationKey, duration, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.scaleKey, scaleFactor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.originalTransformKey, originalTransform, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    @objc private func handleTap() {
        if let action = objc_getAssociatedObject(self, &AssociatedKeys.tapActionKey) as? (() -> Void) {
            action()
        }
    }

    @objc private func handlePress(_ gesture: UILongPressGestureRecognizer) {
        guard
            let duration = objc_getAssociatedObject(self, &AssociatedKeys.durationKey) as? TimeInterval,
            let scaleFactor = objc_getAssociatedObject(self, &AssociatedKeys.scaleKey) as? CGFloat,
            let originalTransform = objc_getAssociatedObject(self, &AssociatedKeys.originalTransformKey) as? CGAffineTransform
        else { return }

        switch gesture.state {
        case .began:
            UIView.animate(withDuration: duration) {
                self.transform = originalTransform.scaledBy(x: scaleFactor, y: scaleFactor)
            }
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: duration) {
                self.transform = originalTransform
            }
        default: break
        }
    }
}

private struct AssociatedKeys {
    static var tapActionKey = "tapActionKey"
    static var durationKey = "durationKey"
    static var scaleKey = "scaleKey"
    static var originalTransformKey = "originalTransformKey"
}
