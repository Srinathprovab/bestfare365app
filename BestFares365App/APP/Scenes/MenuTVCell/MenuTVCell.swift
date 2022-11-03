//
//  MenuTVCell.swift
//  BestFares365App
//
//  Created by FCI on 02/11/22.
//

import UIKit

class MenuTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        menuImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal).withTintColor(.ButtonColor)
        if cellInfo?.key == "ourproducts" {
            holderView.backgroundColor = .BorderColor
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16), align: .left)
    }
    
}
