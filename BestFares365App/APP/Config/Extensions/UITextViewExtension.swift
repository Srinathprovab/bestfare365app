//
//  UITextViewExtension.swift
//  AlghanimTravelApp
//
//  Created by MA673 on 06/09/22.
//

import Foundation
import UIKit

extension UITextView {
    
    func setPlaceholder(str:String) {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = str
        placeholderLabel.font = .poppinsRegular(size: 15)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = HexColor("#7B7B7B")
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}
