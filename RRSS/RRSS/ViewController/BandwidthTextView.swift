//
//  BandwidthTextView.swift
//  RRSS
//
//  Created by Apipon Siripaisan on 10/4/20.
//

import Foundation
import UIKit

@IBDesignable

class BandwidthTextView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }

        
}
