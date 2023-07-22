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
    @IBOutlet weak var rightarrow: UIImageView!
    
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
        menuImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        if cellInfo?.key == "logout" {
            rightarrow.isHidden = true
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        rightarrow.isHidden = false
    }
    
}
