//
//  PassengerDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

protocol PassengerDetailsTVCellDelegate {
    func didTapOnAddPassangerBtnAction(cell:PassengerDetailsTVCell)
    func didTapOnEditPassengerBtn(cell:PassengerDetailsTVCell)
}

class PassengerDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var passengerinfoTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var addPassangerBtnView: UIView!
    @IBOutlet weak var addPassangerlbl: UILabel!
    @IBOutlet weak var addPassangerBtn: UIButton!
    
    var details = ["srinath","taarak"]
    var delegate:PassengerDetailsTVCellDelegate?
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
        tvHeight.constant = CGFloat(details.count * 61)
        passengerinfoTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        addPassangerBtnView.backgroundColor = .ButtonColor
        addPassangerBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        logoImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: addPassangerlbl, text: "+ Add Travellers", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        setuplabels(lbl: titlelbl, text: "Passenger Details", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16), align: .left)
        addPassangerBtn.addTarget(self, action: #selector(didTapOnAddPassangerBtnAction(_:)), for: .touchUpInside)
        setupTV()
        
    }
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "AdultDetailsTVCell", bundle: nil)
        passengerinfoTV.register(nib, forCellReuseIdentifier: "cell")
        passengerinfoTV.delegate = self
        passengerinfoTV.dataSource = self
        passengerinfoTV.tableFooterView = UIView()
        passengerinfoTV.separatorStyle = .none
        passengerinfoTV.isScrollEnabled = false
        
    }
    
    @objc func didTapOnAddPassangerBtnAction(_ sender:UIButton){
        delegate?.didTapOnAddPassangerBtnAction(cell: self)
    }
    
    
    @objc func didTapOnEditPassengerBtn(_ sender:UIButton) {
        delegate?.didTapOnEditPassengerBtn(cell: self)
    }
    
    
}



extension PassengerDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AdultDetailsTVCell {
            cell.titlelbl.text = details[indexPath.row]
            cell.editBtn.addTarget(self, action: #selector(didTapOnEditPassengerBtn(_:)), for: .touchUpInside)
            ccell = cell
        }
        return ccell
    }
    
}
