//
//  DepartureTimeTVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit

class DepartureTimeTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var depTimeCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    
    var array = [String]()
    var array1 = [String]()
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
        array = cellInfo?.moreData as? [String] ?? []
        array1 = cellInfo?.data as? [String] ?? []
        
        switch array.count {
        case 1,2:
            cvHeight.constant = 60
            break
            
        case 3,4:
            cvHeight.constant = 120
            break
        default:
            break
        }
        
        depTimeCV.reloadData()
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16))
        dropdownImg.image = UIImage(named: "droparrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.LabelTitleColor)
        setupCV()
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "DepartureTimeCVCell", bundle: nil)
        depTimeCV.register(nib, forCellWithReuseIdentifier: "cell")
        depTimeCV.delegate = self
        depTimeCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        depTimeCV.backgroundColor = .clear
        depTimeCV.collectionViewLayout = layout
        depTimeCV.isScrollEnabled = false
    }
    
}




extension DepartureTimeTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DepartureTimeCVCell {
            
            if cellInfo?.key == "sort" {
                cell.titlelbl.text = array[indexPath.row]
            }else {
                cell.titlelbl.text = array[indexPath.row]
                cell.subtitlelbl.text = array1[indexPath.row]
            }
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DepartureTimeCVCell {
            cell.selected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DepartureTimeCVCell {
            cell.unselected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 50)
    }
    
}
