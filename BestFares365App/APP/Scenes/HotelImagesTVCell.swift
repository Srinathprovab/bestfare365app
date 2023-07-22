//
//  HotelImagesTVCell.swift
//  BestFares365App
//
//  Created by FCI on 08/11/22.
//

import UIKit

class HotelImagesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelImagesCV: UICollectionView!
    
    
    
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
        holderView.backgroundColor = .WhiteColor
        hotelImage.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        hotelImage.sd_setImage(with: URL(string: hotelImgSelected), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        setupCV()
    }
    
    
    //MARK:- SETUP COLLECTION VIEW
    func setupCV() {
        
        let nib = UINib(nibName: "HotelImageCVCell", bundle: nil)
        hotelImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        hotelImagesCV.delegate = self
        hotelImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        hotelImagesCV.backgroundColor = .clear
        hotelImagesCV.collectionViewLayout = layout
        
    }
    
}



extension HotelImagesTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImageCVCell {
            
            cell.img.sd_setImage(with: URL(string: "\(small_image_baseUrl)\(imageArr[indexPath.row].imagePath ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelImageCVCell {
            self.hotelImage.sd_setImage(with: URL(string: "\(small_image_baseUrl)\(imageArr[indexPath.row].imagePath ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 95, height: 90)
        
    }
    
}
