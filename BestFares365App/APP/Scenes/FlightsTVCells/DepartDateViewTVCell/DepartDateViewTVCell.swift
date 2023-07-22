//
//  DepartDateViewTVCell.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit
import DropDown

protocol DepartDateViewTVCellDelegate {
    func didTapOndepartDateBtn(cell:DepartDateViewTVCell)
    func didTapOnreturnDateBtn(cell:DepartDateViewTVCell)
    func didTapOnCheckinBtn(cell:DepartDateViewTVCell)
    func didTapOnCheckoutBtn(cell:DepartDateViewTVCell)
    func didTapOnNoOfNightsBtn(cell:DepartDateViewTVCell)
    func didTapOnNoOfPersonsBtn(cell:DepartDateViewTVCell)
    
}

class DepartDateViewTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var depCalView: UIView!
    @IBOutlet weak var departDatelbl: UILabel!
    @IBOutlet weak var departDateView: UIView!
    @IBOutlet weak var depCalImg: UIImageView!
    @IBOutlet weak var depCalDatelbl: UILabel!
    @IBOutlet weak var retCalView: UIView!
    @IBOutlet weak var returnDatelbl: UILabel!
    @IBOutlet weak var returnDateView: UIView!
    @IBOutlet weak var retCalImg: UIImageView!
    @IBOutlet weak var retCalDatelbl: UILabel!
    @IBOutlet weak var depBtn: UIButton!
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var downArrowImg: UIImageView!
    
    
    var noofNightsArray = [String]()
    let nightsDropdown = DropDown()
    var noofNightsSelected = String()
    var delegate:DepartDateViewTVCellDelegate?
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            switch tabselect {
            case "Flight":
                if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    switch journyType {
                    case "oneway":
                        departDatelbl.text = "Depart Date"
                        returnDatelbl.isHidden = true
                        returnDateView.isHidden = true
                        retBtn.isHidden = true
                        
                        depCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                        break
                    case "circle":
                        
                        returnDatelbl.isHidden = false
                        returnDateView.isHidden = false
                        retBtn.isHidden = false
                        
                        departDatelbl.text = "Depart Date"
                        returnDatelbl.text = "Return Date"
                        depCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "Select Date"
                        retCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "Select Date"
                        break
                        
                        
                    default:
                        break
                    }
                }
                break
                
                
            case "Hotel":
                
                returnDatelbl.isHidden = false
                returnDateView.isHidden = false
                retBtn.isHidden = false
                if cellInfo?.key == "hotelcheckin" {
                    
                    departDatelbl.text = "Check-In"
                    returnDatelbl.text = "Check-Out"
                    depCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Select Date"
                    retCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Select Date"
                }else {
                    downArrowImg.isHidden = false
                    
                    for i in 0...30 {
                        noofNightsArray.append("\(i)")
                    }
                    nightsDropdown.dataSource = noofNightsArray
                    setpnightsDropdown()
                    
                    departDatelbl.text = "Nights"
                    returnDatelbl.text = "persons"
                    depCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.nights) ?? "Select Nights"
                    retCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "Select Persons"
                }
                break
            default:
                break
            }
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(hotelRooms), name: NSNotification.Name(rawValue: "hotelrooms"), object: nil)
        
    }
    
    
    @objc func hotelRooms() {
        retCalDatelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") Childreen"
        
        defaults.set(retCalDatelbl.text, forKey: UserDefaultsKeys.selectPersons)
    }
    
   
    func setpnightsDropdown() {
        nightsDropdown.direction = .bottom
        nightsDropdown.backgroundColor = .WhiteColor
        nightsDropdown.anchorView = self.departDateView
        nightsDropdown.bottomOffset = CGPoint(x: 0, y: departDateView.frame.size.height + 10)
        nightsDropdown.selectionAction = { [self] (index: Int, item: String) in
            self.noofNightsSelected = item
            self.depCalDatelbl.text = item
            self.delegate?.didTapOnNoOfNightsBtn(cell: self)
        }
    }
    
    
    @objc func reload(_ notify:NSNotification) {
        if let notifystring = notify.object as? String {
            if notifystring == "circle" {
                returnDatelbl.isHidden = false
                returnDateView.isHidden = false
                retBtn.isHidden = false
            }else {
                returnDatelbl.isHidden = true
                returnDateView.isHidden = true
                retBtn.isHidden = true
            }
        }
    }
    
    
    //MARK:- SETUP UI
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        depCalView.backgroundColor = .WhiteColor
        setupLabels(lbl: departDatelbl, text: "Depart Date", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16))
        departDateView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        departDateView.backgroundColor = .WhiteColor
        depCalImg.image = UIImage(named: "caldate")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: depCalDatelbl, text: "23-11-2022", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16))
        downArrowImg.isHidden = true
        downArrowImg.image = UIImage(named: "dropddown")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        
        
        retCalView.backgroundColor = .WhiteColor
        setupLabels(lbl: returnDatelbl, text: "Return Date", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16))
        returnDateView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        returnDatelbl.isHidden = true
        returnDateView.isHidden = true
        retBtn.isHidden = true
        
        // retCalView.isHidden = true
        departDateView.backgroundColor = .WhiteColor
        retCalImg.image = UIImage(named: "caldate")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: retCalDatelbl, text: "24-11-2022", textcolor: .AppLabelColor, font: .SigvarRegular(size: 14))
        
        depBtn.setTitle("", for: .normal)
        retBtn.setTitle("", for: .normal)
        depBtn.addTarget(self, action: #selector(didTapOndepartDateBtn(_:)), for: .touchUpInside)
        retBtn.addTarget(self, action: #selector(didTapOnreturnDateBtn(_:)), for: .touchUpInside)
        
        
    }
    
    //MARK:- SETUP UI LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    //MARK:- SELECT DEPARTURE DATE ACTION
    @objc func didTapOndepartDateBtn(_ sender:UIButton) {
        
        if cellInfo?.key == "hotelcheckin" {
            delegate?.didTapOnCheckinBtn(cell: self)
        }else if cellInfo?.key == "hotelnights" {
            nightsDropdown.show()
        }else {
            delegate?.didTapOndepartDateBtn(cell: self)
        }
    }
    
    //MARK:- SELECT RETURN DATE ACTION
    @objc func didTapOnreturnDateBtn(_ sender:UIButton) {
        if cellInfo?.key == "hotelcheckin" {
            delegate?.didTapOnCheckoutBtn(cell: self)
        }else if cellInfo?.key == "hotelnights" {
            delegate?.didTapOnNoOfPersonsBtn(cell: self)
        }else {
            delegate?.didTapOnreturnDateBtn(cell: self)
        }
    }
    
}
