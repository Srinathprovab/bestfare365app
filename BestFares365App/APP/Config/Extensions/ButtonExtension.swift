//
//  ButtonExtension.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit


extension UIButton {
    func setMainButton(){
        self.backgroundColor = .red
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
    }
    
  
}


extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0 , width:self.frame.size.height, height:width)
        self.layer.addSublayer(border)
    }
    

}
