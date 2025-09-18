//
//  PaddedLabel.swift
//  
//
//  Created by Developer on 9/17/25.
//

import UIKit

final class PaddedLabel: UILabel
            {
                   var insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)

                   override func drawText(in rect: CGRect) {
                       super.drawText(in: rect.inset(by: insets))
                   }

                   override var intrinsicContentSize: CGSize
                {
                       let size = super.intrinsicContentSize
                       return CGSize(width: size.width + insets.left + insets.right,
                                     height: size.height + insets.top + insets.bottom)
                   }
               }
