//
//  RoundTripTVCell.swift
//  BestFares365App
//
//  Created by FCI on 02/11/22.
//

import UIKit
import SDWebImage
protocol RoundTripTVCellDelegate {
    func didTapOnShowFlightDetails(cell:RoundTripTVCell)
    func didTapOnBookNowBtnAction(cell:RoundTripTVCell)

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
    
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    var selectedResult = String()
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
        selectedResult = cellInfo?.title ?? ""
        airlinesLogoImg.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
        pricelbl.text = cellInfo?.price
        if cellInfo?.key == "fd" {
            bookNowView.isHidden = true
            //showDetailslbl.text = "View Flight Details"
        }
        flightSegment = cellInfo?.moreData as? [SegmentSummary] ?? []
        tvHeight.constant = CGFloat(((flightSegment.count ) * 64))
        detailsTV.reloadData()
        
        
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        seatImg.image = UIImage(named: "seat")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: airlinesNamelbl, text: "indigo airlines", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: airlinesCodelbl, text: "(6E 189)", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12))
        setupLabels(lbl: seatsLeftlbl, text: "seat left:6", textcolor: HexColor("#FF0000"), font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: pricelbl, text: "A$ 250", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 16))
        setuplabels(lbl: economylbl, text: "Economy", textcolor: HexColor("#003399"), font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: showDetailslbl, text: "Show details", textcolor: HexColor("#009EE3"), font: .SigvarRegular(size: 16), align: .right)
        
        priceView.backgroundColor = .ButtonColor
        ul.backgroundColor = HexColor("#DADADA")
        showDetailsBtn.setTitle("", for: .normal)
        showDetailsBtn.addTarget(self, action: #selector(didTapOnShowFlightDetails(_:)), for: .touchUpInside)
        
        bookNowView.backgroundColor = .ButtonColor
        bookNowView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 3)
        setuplabels(lbl: bookNowlbl, text: "Book Now", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtnAction(_:)), for: .touchUpInside)
        
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
    
    @objc func didTapOnBookNowBtnAction(_ sender:UIButton){
        delegate?.didTapOnBookNowBtnAction(cell: self)
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
            seatsLeftlbl.text = "Seats left\(data.seatLeft ?? 0)"
            
            self.airlinesLogoImg.sd_setImage(with: URL(string: data.airlineDetails?.flightImage ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
         
            
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
