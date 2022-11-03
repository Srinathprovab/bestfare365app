//
//  ViewController.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit

func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.gotodashBoardScreen()
        })
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}

