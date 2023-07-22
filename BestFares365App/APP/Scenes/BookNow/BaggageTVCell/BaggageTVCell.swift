//
//  BaggageTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class BaggageTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var baggageInfoTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var baggageArray = ["Cabin bag","Checkin"]
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
        tvHeight.constant = CGFloat(baggageArray.count * 50)
    }
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "Baggage info", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20))
        setupTV()
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    func setupTV() {
        
        let nib = UINib(nibName: "BaggageInfoTVCell", bundle: nil)
        baggageInfoTV.register(nib, forCellReuseIdentifier: "cell")
        baggageInfoTV.delegate = self
        baggageInfoTV.dataSource = self
        baggageInfoTV.tableFooterView = UIView()
        baggageInfoTV.separatorStyle = .none
        baggageInfoTV.isScrollEnabled = false
        
    }
    
}



extension BaggageTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baggageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BaggageInfoTVCell {
            cell.titlelbl.text = baggageArray[indexPath.row]
            ccell = cell
        }
        return ccell
    }
    
    
    
}
