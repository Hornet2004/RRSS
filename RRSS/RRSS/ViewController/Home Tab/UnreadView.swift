//
//  UnreadView.swift
//  RRSS
//
//  Created by Apipon Siripaisan on 10/3/20.
//

import UIKit

@IBDesignable

class UnreadView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }

        
}
