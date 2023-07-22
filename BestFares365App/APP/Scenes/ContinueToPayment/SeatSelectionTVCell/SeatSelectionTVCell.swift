//
//  SeatSelectionTVCell.swift
//  BestFares365App
//
//  Created by FCI on 09/11/22.
//

import UIKit
protocol SeatSelectionTVCellDelegate {
    func didTapOnChooseYourSeatBtn(cell:SeatSelectionTVCell)
}

class SeatSelectionTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var seatImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var selectCodesTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var chooseYourSeatView: UIView!
    @IBOutlet weak var chooseYourSeatlbl: UILabel!
    @IBOutlet weak var chooseYourSeatBtn: UIButton!
    
    
    var delegate:SeatSelectionTVCellDelegate?
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
        tvHeight.constant = CGFloat((cityCodesArray.count * 65))
        selectCodesTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        seatImg.image = UIImage(named: "seat")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "Seat Selection", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        chooseYourSeatView.backgroundColor = .ButtonColor
        chooseYourSeatView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        setuplabels(lbl: chooseYourSeatlbl, text: "Choose your Seat", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        chooseYourSeatBtn.addTarget(self, action: #selector(didTapOnChooseYourSeatBtn(_:)), for: .touchUpInside)
        
        setupTV()
    }
    
    
    func setupTV() {
        selectCodesTV.register(UINib(nibName: "SelectCodeTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        selectCodesTV.delegate = self
        selectCodesTV.dataSource = self
        selectCodesTV.tableFooterView = UIView()
        selectCodesTV.showsHorizontalScrollIndicator = false
        selectCodesTV.separatorStyle = .none
        selectCodesTV.isScrollEnabled = false
    }
    
    
    @objc func didTapOnChooseYourSeatBtn(_ sender:UIButton) {
        delegate?.didTapOnChooseYourSeatBtn(cell: self)
    }
    
}



extension SeatSelectionTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityCodesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectCodeTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = cityCodesArray[indexPath.row]
            c = cell
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectCodeTVCell {
            cell.selected()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectCodeTVCell {
            cell.unSelected()
        }
    }
    
}
