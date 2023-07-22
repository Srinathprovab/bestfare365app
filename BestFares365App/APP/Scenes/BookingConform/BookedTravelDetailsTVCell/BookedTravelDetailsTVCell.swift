//
//  BookedTravelDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookedTravelDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var seatlbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var adultDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var cdeatils = [Customer_details]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        cdeatils = cellInfo?.moreData as! [Customer_details]
        
//        vocherdata?.booking_details?.forEach({ i in
//            cdeatils = i.customer_details ?? []
//        })
        
     
        if cdeatils.count > 3 {
            tvHeight.constant = CGFloat(cdeatils.count * 35)
        }
        
        if cellInfo?.key == "hotel" {
            travellerNamelbl.text = "Guest Name"
            typelbl.text = "Type"
            seatlbl.text = "Room Type"
        }
        
        adultDetailsTV.reloadData()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 10)
        
        
        setupViews(v: labelsView, radius: 0, color: .WhiteColor)
        labelsView.layer.borderColor = UIColor.WhiteColor.cgColor
        // labelsView.addBottomBorderWithColor(color: .SubTitleColor, width: 1)
        ulView.backgroundColor = HexColor("#E6E8E7")
        setupLabels(lbl: travellerNamelbl, text: "Traveller Name", textcolor: HexColor("#5B5B5B"), font: .SigvarRegular(size: 14))
        setupLabels(lbl: typelbl, text: "Type", textcolor: HexColor("#5B5B5B"), font: .SigvarRegular(size: 14))
        setupLabels(lbl: seatlbl, text: "Seat", textcolor: HexColor("#5B5B5B"), font: .SigvarRegular(size: 14))
        
    }
    
    func setupTV() {
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        adultDetailsTV.delegate = self
        adultDetailsTV.dataSource = self
        adultDetailsTV.tableFooterView = UIView()
        adultDetailsTV.showsHorizontalScrollIndicator = false
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}


extension BookedTravelDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdeatils.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookedAdultDetailsTVCell {
            cell.selectionStyle = .none
            cell.travellerNamelbl.text = "\(cdeatils[indexPath.row].first_name ?? "") \(cdeatils[indexPath.row].last_name ?? "")"
            cell.typelbl.text = "\(cdeatils[indexPath.row].passenger_type ?? "")"
            cell.seatlbl.text = "\(cdeatils[indexPath.row].ticketNumber ?? "0000")"
            c = cell
        }
        return c
    }
    
    
    
}
