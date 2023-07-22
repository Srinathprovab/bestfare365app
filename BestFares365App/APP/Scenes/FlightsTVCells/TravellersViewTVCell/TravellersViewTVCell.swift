//
//  TravellersViewTVCell.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit
protocol TravellersViewTVCellDelegate {
    func didTapOnAddTravellersBtnAction(cell:TravellersViewTVCell)
    func didTapSelectHotelOrCity(cell:TravellersViewTVCell)

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
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            switch tabselect {
            case "Flight":
                
                travellerslbl.text = "Travellers"
                if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    switch journyType {
                    case "oneway":
                        travellersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Travelllers"
                        break
                    case "circle":
                        travellersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Travelllers"
                        break
                    case "multicity":
                        travellersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "Add Travelllers"
                        break
                    default:
                        break
                    }
                }
                
                break
                
                
            case "Hotel":
                if cellInfo?.key == "hotel" {
                    travellerslbl.text = "Going"
                    travellersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.hotelCity) ?? "Select City or Hotel"
                }
                
                break
            default:
                break
            }
        }
        
    }
    
    func setupUI(){
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: travellerslbl, text: "Travellers", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        travellersView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        travellersView.backgroundColor = .WhiteColor
        travellersImg.image = UIImage(named: "travellers")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: travellersValuelbl, text: "1 Travellers , Economy", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        dropdownImg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal)
        addTraverllersBtn.setTitle("", for: .normal)
        addTraverllersBtn.addTarget(self, action: #selector(didTapOnAddTravellersBtnAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func didTapOnAddTravellersBtnAction(_ sender:UIButton) {
        
        if cellInfo?.key == "hotel" {
            delegate?.didTapSelectHotelOrCity(cell: self)
        }else {
            delegate?.didTapOnAddTravellersBtnAction(cell: self)
        }
    }
    
}
