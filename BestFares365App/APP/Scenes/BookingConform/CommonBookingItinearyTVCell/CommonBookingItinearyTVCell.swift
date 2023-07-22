//
//  CommonBookingItinearyTVCell.swift
//  BestFares365App
//
//  Created by FCI on 25/05/23.
//

import UIKit

class CommonBookingItinearyTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bookingInfoTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    var itinearyDet = [[ItinearyDet]]()
    var itinearyDet1 = [ItinearyDet]()
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
        
        itinearyDet = cellInfo?.moreData as! [[ItinearyDet]]
        itinearyDet.forEach { i in
            itinearyDet1 = i
        }
        tvheight.constant = CGFloat(itinearyDet1.count * 130)
        bookingInfoTV.reloadData()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        bookingInfoTV.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 10)
        
        setupTV()
    }
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "BookingItinearyTVCell", bundle: nil)
        bookingInfoTV.register(nib, forCellReuseIdentifier: "cell")
        bookingInfoTV.delegate = self
        bookingInfoTV.dataSource = self
        bookingInfoTV.tableFooterView = UIView()
        bookingInfoTV.separatorStyle = .none
        bookingInfoTV.isScrollEnabled = false
        
    }
    
    
}



extension CommonBookingItinearyTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itinearyDet1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookingItinearyTVCell {
            
            
            let data = itinearyDet1[indexPath.row]
            cell.fromtimelbl.text = data.originDetails?._DateTime
            cell.totimelbl.text = data.destinationDetails?._DateTime
            cell.fromcitylbl.text = data.originDetails?.cityName
            cell.tocitylbl.text = data.destinationDetails?.cityName
            cell.durationlbl.text = data.segmentDuration
            cell.noofstopslbl.text = "\(data.stops ?? 0) Stops"
            cell.datelbl.text = "\(convertDateFormat(inputDate: data.originDetails?._Date ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
            cell.todatelbl.text = "\(convertDateFormat(inputDate: data.destinationDetails?._Date ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
            
            cell.airlinesnamelbl.text = data.airlineDetails?.airlineName
            cell.airlinescodelbl.text = "(\(data.airlineDetails?.airlineCode ?? "")-\(data.airlineDetails?.flightNumber ?? ""))"
            
            
            cell.logoImg.sd_setImage(with: URL(string: data.originDetails?.operatingImage ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            if indexPath.row == 0 {
                cell.kwdlbl.text = "\(data.fare?.currencySymbol ?? ""):\(data.fare?.totalFare ?? 0)"
            }
            
            if data.stops == 2 {
                cell.img1.isHidden = false
                cell.img2.isHidden = false
                cell.img3.isHidden = true
            }else if data.stops == 1 {
                cell.img1.isHidden = false
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }else {
                cell.img1.isHidden = true
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }
            
            
            if indexPath.row != 0 {
                cell.kwdlbl.isHidden = true
                cell.perpersonlbl.isHidden = true
                
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
}
