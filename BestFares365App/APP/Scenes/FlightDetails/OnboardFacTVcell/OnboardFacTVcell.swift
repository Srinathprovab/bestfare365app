//
//  OnboardFacTVcell.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import UIKit

class OnboardFacTVcell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var detailsTv: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var fd = [FDFlight_details]()
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
        fd = cellInfo?.moreData as! [FDFlight_details]
        
        
        
        if cellInfo?.key == "fac" {
            tvHeight.constant = CGFloat((fd.count ) * 102)
        }else {
            tvHeight.constant = CGFloat((fd.count ) * 50)
        }
        
        detailsTv.reloadData()
    }
    
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
        setupTV()
    }
    
    func setupTV() {
        detailsTv.register(UINib(nibName: "FacilitesDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        detailsTv.register(UINib(nibName: "FDBaggageinfoTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        
        detailsTv.delegate = self
        detailsTv.dataSource = self
        detailsTv.tableFooterView = UIView()
        detailsTv.showsHorizontalScrollIndicator = false
        detailsTv.separatorStyle = .singleLine
        detailsTv.separatorColor = .lightGray
        detailsTv.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        detailsTv.isScrollEnabled = false
    }
    
}



extension OnboardFacTVcell:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellInfo?.key == "fac" {
            return fd.count
        }else {
            return fd.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        if cellInfo?.key == "fac" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FacilitesDetailsTVCell {
                
                let data = fd[indexPath.row]
                cell.titlelbl.text = data.location
                cell.f1lbl.text = data.meal
                cell.f2lbl.text = data.equipmentType
                cell.f3lbl.text = data.seat_pitch
                cell.f4lbl.text = data.power_usb
                c = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FDBaggageinfoTVCell {
                
                let data = fd[indexPath.row]
                if indexPath.row == 0 {
                    cell.titlelbl.text = "Cabin"
                    cell.subtitlelbl.text = data.cabinBaggage
                }else {
                    cell.titlelbl.text = "CheckIn"
                    cell.subtitlelbl.text = data.baggage 
                }
                c = cell
            }
        }
        
        return c
    }
    
}
