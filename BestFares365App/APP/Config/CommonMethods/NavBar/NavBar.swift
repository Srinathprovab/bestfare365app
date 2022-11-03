//
//  NavBar.swift
//  AirportProject
//
//  Created by Codebele 09 on 21/06/22.
//

import UIKit
import Foundation

class NavBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var travellerlbl: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var donelbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    var titleString = String()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
        
        setupuiview()
    }
    
    
    
    func setupuiview(){
        
        contentView.backgroundColor = .NavBackColor
        backBtn.setTitle("", for: .normal)
        editBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        doneBtn.setTitle("", for: .normal)
        
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        setuplabels(lbl: datelbl, text: "", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
        setuplabels(lbl: travellerlbl, text: "", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
        setuplabels(lbl: subtitlelbl, text: "Book Your Flight", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 30), align: .center)
        setupLabels(lbl: donelbl, text: "Done", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 15))
        
        
        setupViews(v: editView, radius: 4, color: .ButtonColor)
        setupViews(v: filterView, radius: 4, color: .ButtonColor)
        setupViews(v: backView, radius: 17.5, color: .clear)
        setupViews(v: doneView, radius: 5, color: .WhiteColor)
        
        backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        bannerImg.image = UIImage(named: "flightbanner")?.withRenderingMode(.alwaysOriginal)
        editImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal)
        
        
        editView.isHidden = true
        filterView.isHidden = true
        editImg.image = UIImage(named: "edit")
        filterImg.image = UIImage(named: "filter")
        
        titlelbl.isHidden = false
        datelbl.isHidden = true
        travellerlbl.isHidden = true
        bannerImg.isHidden = true
        subtitlelbl.isHidden = true
        doneView.isHidden = true
        bannerImg.contentMode = .scaleToFill
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
}



