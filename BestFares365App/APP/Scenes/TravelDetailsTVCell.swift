//
//  TravelDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 09/11/22.
//

import UIKit


class TravelDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var travelDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
  
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
        tvHeight.constant = (5 * 56)
        travelDetailsTV.reloadData()
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .clear, cornerRadius: 6)
        setuplabels(lbl: titlelbl, text: "Travel Details ", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        ul.backgroundColor = .BorderColor
        setupTV()
    }
    
    
    func setupTV() {
        travelDetailsTV.register(UINib(nibName: "TDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        travelDetailsTV.delegate = self
        travelDetailsTV.dataSource = self
        travelDetailsTV.tableFooterView = UIView()
        travelDetailsTV.showsHorizontalScrollIndicator = false
        travelDetailsTV.separatorStyle = .none
        travelDetailsTV.isScrollEnabled = false
    }
    
    
    
}



extension TravelDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TDetailsTVCell {
            if indexPath.row == 0 {
                cell.show()
            }
            c = cell
        }
        return c
    }
    
}
