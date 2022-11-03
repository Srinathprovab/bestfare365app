//
//  SelectCabinClassTVCell.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

class SelectCabinClassTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var classCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    var price = [String]()
    var classArray = ["Economy","Premium Economy","Frist","Business"]
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
        price = cellInfo?.moreData as? [String] ?? []
        cvHeight.constant = 120
        setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 16))
        setupCV()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "SelectClassCVCell", bundle: nil)
        classCV.register(nib, forCellWithReuseIdentifier: "cell")
        classCV.delegate = self
        classCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        classCV.backgroundColor = .clear
        classCV.collectionViewLayout = layout
        classCV.isScrollEnabled = false
        
        
    }
    
}

extension SelectCabinClassTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellInfo?.key == "sortbyprice" {
            return price.count
        }else {
            return classArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectClassCVCell {
            
            if cellInfo?.key == "sortbyprice" {
                cvHeight.constant = 120
                setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16))
                cell.setupSortByFilterView()
                cell.titlelbl.text = price[indexPath.row]
                
            }else {
                cell.titlelbl.text = classArray[indexPath.row]
            }
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
            
            if cellInfo?.key == "sortbyprice" {
                
            }else {
                if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    switch journyType {
                    case "oneway":
                        defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.selectClass)
                        break
                    case "circle":
                        defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.rselectClass)
                        break
                    case "multicity":
                        defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.mselectClass)
                        break
                    default:
                        break
                    }
                }
            }
            
            cell.selected()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
            cell.unselected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        
        if cellInfo?.key == "sortbyprice" {
            return CGSize(width: 160, height: 50)
        }else {
            let label = UILabel(frame: CGRect.zero)
            label.text = classArray[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 25, height: 40)
        }
        
    }
    
    
    
}
