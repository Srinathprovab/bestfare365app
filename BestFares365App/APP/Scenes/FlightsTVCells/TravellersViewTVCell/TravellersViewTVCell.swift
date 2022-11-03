//
//  TravellersViewTVCell.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit
protocol TravellersViewTVCellDelegate {
    func didTapOnAddTravellersBtnAction(cell:TravellersViewTVCell)
}

class TravellersViewTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var travellerslbl: UILabel!
    @IBOutlet weak var travellersView: UIView!
    @IBOutlet weak var travellersImg: UIImageView!
    @IBOutlet weak var travellersValuelbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var addTraverllersBtn: UIButton!
    
    var delegate:TravellersViewTVCellDelegate?
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
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                travellersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Travelllers"
                break
            case "circle":
                travellersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Travelllers"
                break
            case "multicity":
                
                break
            default:
                break
            }
        }
    }
    
    func setupUI(){
        
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: travellerslbl, text: "Travellers", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        travellersView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        travellersView.backgroundColor = .WhiteColor
        travellersImg.image = UIImage(named: "travellers")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: travellersValuelbl, text: "1 Travellers , Economy", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 16))
        dropdownImg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal)
        addTraverllersBtn.setTitle("", for: .normal)
        addTraverllersBtn.addTarget(self, action: #selector(didTapOnAddTravellersBtnAction(_:)), for: .touchUpInside)
        
    }
    
    //MARK:- SETUP UI LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @objc func didTapOnAddTravellersBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAddTravellersBtnAction(cell: self)
    }
    
}
