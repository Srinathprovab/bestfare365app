//
//  DepartDateViewTVCell.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit
protocol DepartDateViewTVCellDelegate {
    func didTapOndepartDateBtn(cell:DepartDateViewTVCell)
    func didTapOnreturnDateBtn(cell:DepartDateViewTVCell)
    
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
        
        if cellInfo?.key == "ret" {
            retCalView.isHidden = false
        }
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                depCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                break
            case "circle":
                
                depCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "Select Date"
                retCalDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "Select Date"
                
                break
            
            default:
                break
            }
        }
        
        
        
        self.layoutIfNeeded()
       

    }
    
    
    //MARK:- SETUP UI
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        depCalView.backgroundColor = .WhiteColor
        setupLabels(lbl: departDatelbl, text: "Depart Date", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        departDateView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        departDateView.backgroundColor = .WhiteColor
        depCalImg.image = UIImage(named: "caldate")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: depCalDatelbl, text: "23-11-2022", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 14))
        
        
        
        retCalView.backgroundColor = .WhiteColor
        setupLabels(lbl: returnDatelbl, text: "Return Date", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        returnDateView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
//        returnDatelbl.isHidden = true
//        returnDateView.isHidden = true
//        retBtn.isHidden = true
        
        retCalView.isHidden = true
        departDateView.backgroundColor = .WhiteColor
        retCalImg.image = UIImage(named: "caldate")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: retCalDatelbl, text: "24-11-2022", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 14))
        
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
        delegate?.didTapOndepartDateBtn(cell: self)
    }
    
    //MARK:- SELECT RETURN DATE ACTION
    @objc func didTapOnreturnDateBtn(_ sender:UIButton) {
        delegate?.didTapOnreturnDateBtn(cell: self)
    }
    
}
