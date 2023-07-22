//
//  PassengerDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit
import CoreData

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
    @IBOutlet weak var totalTravellerlbl: UILabel!
    
    
  //  var details = ["srinath","taarak"]
    var adetails  = [NSFetchRequestResult]()
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
        
    //    details = cellInfo?.moreData as! [any NSFetchRequestResult]
        
        titlelbl.text = cellInfo?.title
        fetchAdultCoreDataValues(str: "Adult")
        tvHeight.constant = CGFloat(adetails.count * 61)
        passengerinfoTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        addPassangerBtnView.backgroundColor = .ButtonColor
        addPassangerBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        logoImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: addPassangerlbl, text: "+ Add Travellers", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        setuplabels(lbl: titlelbl, text: "Passenger Details", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        addPassangerBtn.addTarget(self, action: #selector(didTapOnAddPassangerBtnAction(_:)), for: .touchUpInside)
        
        setuplabels(lbl: totalTravellerlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "")", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 14), align: .right)
        
        
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
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            if str == "Adult" {
                adetails = try context.fetch(request)
            }else if str == "Children" {
              //  cdetails = try context.fetch(request)
            }else {
              //  idetails = try context.fetch(request)
            }
            
            if adetails.count > 0 {
                addPassangerBtnView.isHidden = true
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
}



extension PassengerDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AdultDetailsTVCell {
            
            let data = adetails as! [NSManagedObject]
            cell.titlelbl.text = "\(data[indexPath.row].value(forKey: "fname") as? String ?? "") \(data[indexPath.row].value(forKey: "lname") as? String ?? "")"
            cell.editBtn.addTarget(self, action: #selector(didTapOnEditPassengerBtn(_:)), for: .touchUpInside)
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let data = details as! [NSManagedObject]
            let userinfo = ["id":"\(data[indexPath.row].value(forKey: "id") ?? "")",
                            "index":"\(indexPath.row)"]
            
            NotificationCenter.default.post(name: NSNotification.Name("delete"), object: nil,userInfo: userinfo)
        }
    }
    
}
