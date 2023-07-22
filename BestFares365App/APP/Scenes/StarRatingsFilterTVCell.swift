//
//  StarRatingsFilterTVCell.swift
//  BestFares365App
//
//  Created by FCI on 25/05/23.
//

import UIKit


protocol StarRatingsFilterTVCellDelegate {
    func didTapOnStarRatingBtnAction(cell:StarRatingsFilterTVCell)
}

class StarRatingsFilterTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var downarrow: UIImageView!
    @IBOutlet weak var starviewsHeight: NSLayoutConstraint!
    @IBOutlet weak var starView1: UIView!
    @IBOutlet weak var starView2: UIView!
    @IBOutlet weak var starView3: UIView!
    @IBOutlet weak var starView4: UIView!
    @IBOutlet weak var starView5: UIView!
    @IBOutlet weak var starImg1: UIImageView!
    @IBOutlet weak var starImg2: UIImageView!
    @IBOutlet weak var starImg3: UIImageView!
    @IBOutlet weak var starImg4: UIImageView!
    @IBOutlet weak var starImg5: UIImageView!
    @IBOutlet weak var starBtn1: UIButton!
    @IBOutlet weak var starBtn2: UIButton!
    @IBOutlet weak var starBtn3: UIButton!
    @IBOutlet weak var starBtn4: UIButton!
    @IBOutlet weak var starBtn5: UIButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    
    
    var selectedStarValue = String()
    var delegate:StarRatingsFilterTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        starView1.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 6)
        starView2.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 6)
        starView3.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 6)
        starView4.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 6)
        starView5.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 6)
        starBtn1.setTitle("", for: .normal)
        starBtn1.tag = 1
        starBtn1.addTarget(self, action: #selector(didTapOnStarRatingBtnAction(_:)), for: .touchUpInside)
        starBtn2.setTitle("", for: .normal)
        starBtn2.tag = 2
        starBtn2.addTarget(self, action: #selector(didTapOnStarRatingBtnAction(_:)), for: .touchUpInside)
        starBtn3.setTitle("", for: .normal)
        starBtn3.tag = 3
        starBtn3.addTarget(self, action: #selector(didTapOnStarRatingBtnAction(_:)), for: .touchUpInside)
        starBtn4.setTitle("", for: .normal)
        starBtn4.tag = 4
        starBtn4.addTarget(self, action: #selector(didTapOnStarRatingBtnAction(_:)), for: .touchUpInside)
        starBtn5.setTitle("", for: .normal)
        starBtn5.tag = 5
        starBtn5.addTarget(self, action: #selector(didTapOnStarRatingBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapOnStarRatingBtnAction(_ sender:UIButton) {
        
        switch sender.tag {
        case 1:
            selectedStarValue = "1"
            setupviewselected(lbl: lbl1, img: starImg1)
            setupviewunselected(lbl: lbl2, img: starImg2)
            setupviewunselected(lbl: lbl3, img: starImg3)
            setupviewunselected(lbl: lbl4, img: starImg4)
            setupviewunselected(lbl: lbl5, img: starImg5)
            break
            
        case 2:
            selectedStarValue = "2"
            setupviewselected(lbl: lbl2, img: starImg2)
            setupviewunselected(lbl: lbl1, img: starImg1)
            setupviewunselected(lbl: lbl3, img: starImg3)
            setupviewunselected(lbl: lbl4, img: starImg4)
            setupviewunselected(lbl: lbl5, img: starImg5)
            break
            
        case 3:
            selectedStarValue = "3"
            setupviewselected(lbl: lbl3, img: starImg3)
            setupviewunselected(lbl: lbl2, img: starImg2)
            setupviewunselected(lbl: lbl1, img: starImg1)
            setupviewunselected(lbl: lbl4, img: starImg4)
            setupviewunselected(lbl: lbl5, img: starImg5)
            break
            
        case 4:
            selectedStarValue = "4"
            setupviewselected(lbl: lbl4, img: starImg4)
            setupviewunselected(lbl: lbl2, img: starImg2)
            setupviewunselected(lbl: lbl3, img: starImg3)
            setupviewunselected(lbl: lbl1, img: starImg1)
            setupviewunselected(lbl: lbl5, img: starImg5)
            break
            
        case 5:
            selectedStarValue = "5"
            setupviewselected(lbl: lbl5, img: starImg5)
            setupviewunselected(lbl: lbl2, img: starImg2)
            setupviewunselected(lbl: lbl3, img: starImg3)
            setupviewunselected(lbl: lbl4, img: starImg4)
            setupviewunselected(lbl: lbl1, img: starImg1)
            break
            
        default:
            break
        }
        
        delegate?.didTapOnStarRatingBtnAction(cell: self)
    }
    
    
    func setupviewselected(lbl:UILabel,img:UIImageView) {
        lbl.textColor = HexColor("#009DEA")
        img.image = UIImage(named: "star2")?.withRenderingMode(.alwaysOriginal)
    }
    
    func setupviewunselected(lbl:UILabel,img:UIImageView) {
        lbl.textColor = .AppLabelColor
        img.image = UIImage(named: "star1")?.withRenderingMode(.alwaysOriginal)
    }
}
