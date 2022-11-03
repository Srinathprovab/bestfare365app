//
//  FareSummaryTVCell.swift
//  BestFares365App
//
//  Created by FCI on 01/11/22.
//

import UIKit

class FareSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var fareSummeryTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var GrandTotalTitlelbl: UILabel!
    @IBOutlet weak var GrandTotalValuelbl: UILabel!
    
    var array = ["Bare fare","Taxes & fees"]
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
        tvHeight.constant = CGFloat(array.count * 80)
        fareSummeryTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        logoImg.image = UIImage(named: "fee")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "Fare summary", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16), align: NSTextAlignment.left)
        setuplabels(lbl: GrandTotalTitlelbl, text: "Grand Total", textcolor: HexColor("#009EE3"), font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: GrandTotalValuelbl, text: "A$300", textcolor: HexColor("#009EE3"), font: .ProximaNovaBold(size: 16), align: .right)
        setupTV()
    }
    
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "BarefareTVCell", bundle: nil)
        fareSummeryTV.register(nib, forCellReuseIdentifier: "cell")
        fareSummeryTV.delegate = self
        fareSummeryTV.dataSource = self
        fareSummeryTV.tableFooterView = UIView()
        fareSummeryTV.separatorStyle = .none
        fareSummeryTV.isScrollEnabled = false
        
    }
    
}



extension FareSummaryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BarefareTVCell {
            cell.titlelbl.text = array[indexPath.row]
            ccell = cell
        }
        return ccell
    }
    
    
}
