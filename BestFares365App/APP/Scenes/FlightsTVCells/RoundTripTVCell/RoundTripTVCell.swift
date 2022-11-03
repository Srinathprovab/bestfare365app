//
//  RoundTripTVCell.swift
//  BestFares365App
//
//  Created by FCI on 02/11/22.
//

import UIKit

protocol RoundTripTVCellDelegate {
    func didTapOnShowFlightDetails(cell:RoundTripTVCell)
}

class RoundTripTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinesLogoImg: UIImageView!
    @IBOutlet weak var airlinesNamelbl: UILabel!
    @IBOutlet weak var airlinesCodelbl: UILabel!
    @IBOutlet weak var seatsLeftlbl: UILabel!
    @IBOutlet weak var seatImg: UIImageView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var showDetailslbl: UILabel!
    @IBOutlet weak var showDetailsBtn: UIButton!
    @IBOutlet weak var detailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    
    var flightSegment = [SegmentSummary]()
    var delegate:RoundTripTVCellDelegate?
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
        airlinesLogoImg.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
//        airlinesNamelbl.text = cellInfo?.airlinesname
//        airlinesCodelbl.text = cellInfo?.airlinesCode
//        seatsLeftlbl.text = cellInfo?.seatsLeft
        pricelbl.text = cellInfo?.price
        flightSegment = cellInfo?.moreData as? [SegmentSummary] ?? []
        tvHeight.constant = CGFloat(((flightSegment.count ) * 64))
        detailsTV.reloadData()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        seatImg.image = UIImage(named: "seat")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: airlinesNamelbl, text: "indigo airlines", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: airlinesCodelbl, text: "(6E 189)", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 12))
        setupLabels(lbl: seatsLeftlbl, text: "seat left:6", textcolor: HexColor("#FF0000"), font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: pricelbl, text: "A$ 250", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 16))
        setupLabels(lbl: economylbl, text: "Economy", textcolor: HexColor("#003399"), font: .SigvarRegular(size: 16))
        setupLabels(lbl: showDetailslbl, text: "Show details", textcolor: HexColor("#009EE3"), font: .SigvarRegular(size: 16))
        
        priceView.backgroundColor = .ButtonColor
        ul.backgroundColor = HexColor("#DADADA")
        showDetailsBtn.setTitle("", for: .normal)
        showDetailsBtn.addTarget(self, action: #selector(didTapOnShowFlightDetails(_:)), for: .touchUpInside)
        setupTV()
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "RoundTripDetailsTVCell", bundle: nil)
        detailsTV.register(nib, forCellReuseIdentifier: "cell")
        detailsTV.delegate = self
        detailsTV.dataSource = self
        detailsTV.tableFooterView = UIView()
        detailsTV.separatorStyle = .none
        detailsTV.isScrollEnabled = false
        
    }
    
    
    @objc func didTapOnShowFlightDetails(_ sender:UIButton) {
        delegate?.didTapOnShowFlightDetails(cell: self)
    }
    
}



extension RoundTripTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightSegment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RoundTripDetailsTVCell {
            
            
            let data = flightSegment[indexPath.row]
            cell.fromTimelbl.text = data.originDetails?._DateTime
            cell.toTimelbl.text = data.destinationDetails?._DateTime
            cell.fromCodelbl.text = data.originDetails?.cityName
            cell.toCodelbl.text = data.destinationDetails?.cityName
            cell.travelTimelbl.text = data.totalDuaration
            cell.totalStopslbl.text = "\(String(data.totalStops ?? 0)) Stops"
            cell.kglbl.text = data.originDetails?.baggage
            
            airlinesNamelbl.text = data.airlineDetails?.airlineName
            airlinesCodelbl.text = data.airlineDetails?.airlineCode
            seatsLeftlbl.text = "0"
         
            
            if data.totalStops == 0 {
                cell.img1.isHidden = true
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }else if data.totalStops == 1 {
                cell.img1.isHidden = false
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }else {
                cell.img1.isHidden = false
                cell.img2.isHidden = false
                cell.img3.isHidden = true
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
}
