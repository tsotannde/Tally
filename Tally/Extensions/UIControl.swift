//
//  UIControl.swift
//  
//
//  Created by Developer on 9/15/25.
//


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
