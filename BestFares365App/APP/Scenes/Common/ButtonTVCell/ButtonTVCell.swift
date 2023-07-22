//
//  ButtonTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol ButtonTVCellDelegate {
    func btnAction(cell: ButtonTVCell)
    func didTapOnAddRoomBtnAction(cell: ButtonTVCell)
}

class ButtonTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btnImg: UIImageView!
    @IBOutlet weak var btnLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var addRoomBtn: UIButton!
    
    
    var key = String()
    var delegate:ButtonTVCellDelegate?
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
        btnView.backgroundColor = cellInfo?.bgColor
        self.key = cellInfo?.key ?? ""
        
        switch self.key {
        case "login":
            btnLeftConstraint.constant = 50
            break
            
        case "profile":
            btnLeftConstraint.constant = 25
            break
            
            
        case "addroom":
            
            btnView.isHidden = true
            addRoomBtn.setTitle(cellInfo?.title, for: .normal)
            addRoomBtn.setTitleColor(.ButtonColor, for: .normal)
            addRoomBtn.isHidden = false
            break
            
            
        case "addroomdone":
            btnView.isHidden = false
            addRoomBtn.isHidden = true
            break
            
            
        case "btn" :
            btnView.backgroundColor = .ButtonColor
            break
            
            
        default:
            break
        }
    }
    
    func setupUI(){
        
        btnLeftConstraint.constant = 16
        holderView.backgroundColor = .WhiteColor
        btnView.backgroundColor = .ButtonColor
        btnView.layer.cornerRadius = 4
        btnView.clipsToBounds = true
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.ProximaNovaBold(size: 18)
        btnImg.image = UIImage(named: "download")?.withRenderingMode(.alwaysOriginal)
        btnImg.isHidden = true
        btn.setTitle("", for: .normal)
        btnView.isHidden = false
        addRoomBtn.isHidden = true
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        delegate?.btnAction(cell: self)
    }
    
    
    @IBAction func didTapOnAddRoomBtnAction(_ sender: Any) {
        delegate?.didTapOnAddRoomBtnAction(cell: self)
    }
}
