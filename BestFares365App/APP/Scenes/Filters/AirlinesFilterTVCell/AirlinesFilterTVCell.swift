//
//  AirlinesFilterTVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit
protocol AirlinesFilterTVCellDelegate {
    func showMoreButtonAction(cell:AirlinesFilterTVCell)
}

class AirlinesFilterTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var airlinesTV: UITableView!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var showBtnHeight: NSLayoutConstraint!
    
    var airlinesListArray = [String]()
    var delegate:AirlinesFilterTVCellDelegate?
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
        airlinesListArray = cellInfo?.moreData as? [String] ?? []
        titlelbl.text = cellInfo?.title
        
        if cellInfo?.key == "arriving" {
            tvHeight.constant = CGFloat((airlinesListArray.count * 56))
        }else if cellInfo?.key == "connecting" {
            tvHeight.constant = CGFloat((airlinesListArray.count * 56))
        }else {
            tvHeight.constant = (5 * 56)
        }
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16))
        showMoreBtn.setTitle("Show more", for: .normal)
        showMoreBtn.addTarget(self, action: #selector(showMoreButtonAction(_:)), for: .touchUpInside)
        setupTV()
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    func setupTV() {
        
        let nib = UINib(nibName: "AirlinesNameTVCell", bundle: nil)
        airlinesTV.register(nib, forCellReuseIdentifier: "cell")
        airlinesTV.delegate = self
        airlinesTV.dataSource = self
        airlinesTV.tableFooterView = UIView()
        airlinesTV.separatorStyle = .none
        airlinesTV.isScrollEnabled = false
        
    }
    
    
    @objc func showMoreButtonAction(_ sender:UIButton) {
        delegate?.showMoreButtonAction(cell: self)
    }
    
}



extension AirlinesFilterTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airlinesListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AirlinesNameTVCell {
            
            if cellInfo?.key == "arriving" {
                cell.hideLogoImage()
                setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
                showBtnHeight.constant = 0
            }else if cellInfo?.key == "connecting" {
                cell.hideLogoImage()
                setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
                showBtnHeight.constant = 0
            }else {
                cell.logoImgWidth.constant = 35
            }
            
            cell.titlelbl.text = airlinesListArray[indexPath.row]
            ccell = cell
        }
        return ccell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AirlinesNameTVCell {
            cell.selected()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AirlinesNameTVCell {
            cell.unselected()
        }
    }
    
    
    
}
