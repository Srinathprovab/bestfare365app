//
//  BottomFilterTVCell.swift
//  BestFares365App
//
//  Created by FCI on 29/10/22.
//

import UIKit

protocol BottomFilterTVCellDelegate {
    func didTapOnFilterBtn(cell:SelectClassCVCell)
}

class BottomFilterTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var noOfStopsCV: UICollectionView!
    
    var delegate:BottomFilterTVCellDelegate?
    var noofstopsArray = ["Non Stop","1 Stop","1+ stop"]
    var freecancellation = ["Refundable","Non Refundable"]
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
        filterBtn.setTitle("", for: .normal)
        holderView.addCornerRadiusWithShadow(color: .AppLabelColor.withAlphaComponent(0.16), borderColor: .BorderColor, cornerRadius: 5)
        setupLabels(lbl: titlelbl, text: "no of stops", textcolor: .AppLabelColor, font: .SigvarRegular(size: 14))
        
        setupCV()
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    func setupCV() {
        
        let nib = UINib(nibName: "SelectClassCVCell", bundle: nil)
        noOfStopsCV.register(nib, forCellWithReuseIdentifier: "cell")
        noOfStopsCV.delegate = self
        noOfStopsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        noOfStopsCV.backgroundColor = .clear
        noOfStopsCV.collectionViewLayout = layout
        noOfStopsCV.isScrollEnabled = false
    }
    
    
}



extension BottomFilterTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if let tabselect1 = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            
            if tabselect1 == "Flight" {
                return noofstopsArray.count
            }else {
                return freecancellation.count
            }
            
        }else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectClassCVCell {
            
            if let tabselect1 = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                
                if tabselect1 == "Flight" {
                    cell.titlelbl.text = noofstopsArray[indexPath.row]
                    cell.titlelbl.font = .SigvarRegular(size: 14)
                    
                    if indexPath.row == noofStopsFilterIndex {
                        collectionView.selectItem(at: IndexPath(item: noofStopsFilterIndex, section: 0), animated: true, scrollPosition: .left)
                        cell.selected()
                    }
                }else {
                    cell.titlelbl.text = freecancellation[indexPath.row]
                    cell.titlelbl.font = .SigvarRegular(size: 14)
                    
                    if indexPath.row == noofStopsFilterIndex {
                        collectionView.selectItem(at: IndexPath(item: noofStopsFilterIndex, section: 0), animated: true, scrollPosition: .left)
                        cell.selected()
                    }
                }
                
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
            delegate?.didTapOnFilterBtn(cell: cell)
            noofStopsFilterIndex = indexPath.row
            cell.selected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
            cell.unselected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        
        if let tabselect1 = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            
            if tabselect1 == "Flight" {
                label.text = noofstopsArray[indexPath.item]
            }else {
                label.text = freecancellation[indexPath.item]
            }
            
        }
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: 40)
        
        
    }
    
}
