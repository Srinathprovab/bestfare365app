//
//  EmptyTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit


class EmptyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var ulView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.backgroundColor = .WhiteColor
        ulView.backgroundColor = HexColor("#A6A6A6")
        ulView.isHidden = true
    }
    
    override func updateUI() {
        viewHeight.constant = cellInfo?.height ?? 10
        holderView.backgroundColor = cellInfo?.bgColor
        
        
        switch cellInfo?.key {
        case "line":
            ulView.isHidden = false
            break
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
