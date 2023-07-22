//
//  SignUpWithTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
protocol SignUpWithTVCellDelegate {
    func didTapOnGoogleBtn(cell: SignUpWithTVCell)
}

class SignUpWithTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var btnHolderView: UIView!
    @IBOutlet weak var gImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var delegate:SignUpWithTVCellDelegate?
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
        //titlelbl.text = cellInfo?.title
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        btnHolderView.backgroundColor = .WhiteColor
        btnHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        gImage.image = UIImage(named: "google")
        setuplabels(lbl: titlelbl, text: "Google", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
    }
    
    
    @IBAction func didTapOnGoogleBtn(_ sender: Any) {
        delegate?.didTapOnGoogleBtn(cell: self)
    }
    
    
}
