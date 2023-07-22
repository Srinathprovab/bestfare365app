//
//  SelectGenderTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol SelectGenderTVCellDelegate {
    
    func didSelectMaleRadioBtn(cell:SelectGenderTVCell)
    func didSelectOnFemaleBtn(cell:SelectGenderTVCell)
    func didSelectOnOthersBtn(cell:SelectGenderTVCell)
    func didTapOnSaveBtn(cell:SelectGenderTVCell)
    
}

class SelectGenderTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var maleRadioImg: UIImageView!
    @IBOutlet weak var malelbl: UILabel!
    @IBOutlet weak var femaleRadioImg: UIImageView!
    @IBOutlet weak var femalelbl: UILabel!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var genderView: UIStackView!
    @IBOutlet weak var saveBtnView: UIView!
    @IBOutlet weak var savelbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var otherImg: UIImageView!
    @IBOutlet weak var otherslbl: UILabel!
    @IBOutlet weak var othersBtn: UIButton!
    
    var gender = String()
    var delegate:SelectGenderTVCellDelegate?
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
        if cellInfo?.key == "gender" {
            saveBtnView.isHidden = true
            genderView.isHidden = false
        }else {
            saveBtnView.isHidden = false
            genderView.isHidden = true
        }
        
        if cellInfo?.title == "Male" {
            maleSetup()
        }else if cellInfo?.title == "Female" {
            femaleSetup()
        }else {
            othersSetup()
        }
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        otherImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: malelbl, text: "Male", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: femalelbl, text: "Female", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: otherslbl, text: "Others", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: savelbl, text: "Save", textcolor: .WhiteColor, font: .SigvarRegular(size: 16), align: .center)
        setupViews(v: saveBtnView, radius: 4, color: .ButtonColor)
        
        maleBtn.setTitle("", for: .normal)
        femaleBtn.setTitle("", for: .normal)
        othersBtn.setTitle("", for: .normal)
        saveBtn.setTitle("", for: .normal)
        saveBtnView.isHidden = true
        genderView.isHidden = false
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    @IBAction func didSelectMaleRadioBtn(_ sender: Any) {
        maleSetup()
    }
    
    func maleSetup(){
        gender = "Male"
        maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.ButtonColor)
        femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        otherImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        delegate?.didSelectMaleRadioBtn(cell: self)
    }
    
    @IBAction func didSelectOnFemaleBtn(_ sender: Any) {
        femaleSetup()
    }
    
    func femaleSetup(){
        gender = "Female"
        maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        femaleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.ButtonColor)
        otherImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        delegate?.didSelectOnFemaleBtn(cell: self)
    }
    
    
    @IBAction func didTapOnOthersBtn(_ sender: Any) {
        othersSetup()
    }
    
    func othersSetup(){
        gender = "Others"
        maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        otherImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.ButtonColor)
        delegate?.didSelectOnOthersBtn(cell: self)
    }
    
    
    @IBAction func didTapOnSaveBtn(_ sender: Any) {
        delegate?.didTapOnSaveBtn(cell: self)
    }
    
}
