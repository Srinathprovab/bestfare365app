//
//  FDTVCell.swift
//  BestFares365App
//
//  Created by FCI on 04/11/22.
//

import UIKit

class FDTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fdDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var flight_details1: [FDFlight_details]?
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
        flight_details1 = cellInfo?.moreData as? [FDFlight_details]
        tvHeight.constant = CGFloat((flight_details1?.count ?? 0) * 190)
        fdDetailsTV.reloadData()
    }
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        holderView.backgroundColor = .WhiteColor
        setupTV()
    }
    
    func setupTV() {
        
        let nib = UINib(nibName: "FlightDetailTVCell", bundle: nil)
        fdDetailsTV.register(nib, forCellReuseIdentifier: "cell")
        fdDetailsTV.delegate = self
        fdDetailsTV.dataSource = self
        fdDetailsTV.tableFooterView = UIView()
        fdDetailsTV.separatorStyle = .none
        fdDetailsTV.isScrollEnabled = false
        
    }
    
}



extension FDTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flight_details1?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightDetailTVCell {
            
            let data = flight_details1?[indexPath.row]
            
            cell.airlinesNamelbl1.text = "\(data?.airlineDetails?.airlineName ?? "") (\(data?.airlineDetails?.fareClass ?? "") \(data?.airlineDetails?.airlineCode ?? ""))"
            cell.hourslbl1.text = data?.segmentDuration
            cell.fromTimelbl1.text = data?.originDetails?._DateTime
            cell.fromCitylbl1.text = data?.originDetails?.cityName
            cell.fromDatelbl1.text = data?.originDetails?._Date
            cell.fromAirportNamelbl1.text = data?.originDetails?.airportName
            cell.fromTerminallbl1.text = "Terminal: \(data?.originDetails?.terminal ?? "0")"
            cell.toTimelbl1.text = data?.destinationDetails?._DateTime
            cell.toCitylbl1.text = data?.destinationDetails?.cityName
            cell.toDatelbl1.text = data?.destinationDetails?._Date
            cell.toAirportNamelbl1.text = data?.destinationDetails?.airportName
            cell.toTerminallbl1.text = "Terminal: \(data?.destinationDetails?.terminal ?? "0")"
            cell.stopoverTimelbl.text = "Stopover: \(data?.waitingTime ?? "222")"
            cell.stopoverCitylbl.text = "(\(data?.destinationDetails?.airportCode ?? ""))\(data?.destinationDetails?.cityName ?? "")"
            
            cell.airlinesLogoImg1.sd_setImage(with: URL(string: data?.airlineDetails?.flightImage ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

            
            let lastRowIndex = tableView.numberOfRows(inSection: tableView.numberOfSections-1)
            if (indexPath.row == lastRowIndex - 1) {
                cell.stopoverView.isHidden = true
            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
}
