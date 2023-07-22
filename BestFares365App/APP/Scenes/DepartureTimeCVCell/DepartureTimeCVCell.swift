//
//  DepartureTimeCVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit

class DepartureTimeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    
    var filterTitle = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func prepareForReuse() {
        unselected()
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 16)
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .center)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .center)
    }
    
    
    
    func selected() {
        holderView.backgroundColor = .CalSelectedColor
        titlelbl.textColor = .WhiteColor
        subtitlelbl.textColor = .WhiteColor
    }
    
    
    func unselected() {
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = .AppLabelColor
        subtitlelbl.textColor = .AppLabelColor
    }
    
    
    
}
