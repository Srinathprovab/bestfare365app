//
//  AddAdultTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit
import CoreData


struct Passenger {
    var passengerType: String
    var title2Code: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var passportNumber: String
    var passportNationality: String
    var passportIssuingCountry: String
    var middleName: String
    var isLeadPassenger: String
    var gender: String
    var passportExpiryDay: String
    var passportExpiryMonth: String
    var passportExpiryYear: String
    var passenger_passport_expiry_date:String
}


protocol AddAdultTravellerTVCellDelegate {
    
    
    func didTapOnAddAdultBtn(cell:AddAdultTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddAdultTravellerTVCell: TableViewCell, AddAdultsOrGuestTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var travelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var totalNoOfTravellerlbl: UILabel!
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    
    
    var adultsCount = 1
    var delegate:AddAdultTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var adetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        
    }
    
    
    override func updateUI() {
        checkOptionCountArray.removeAll()
        details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
        fetchAdultCoreDataValues(str: "Adult")
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
            }
        }
        
        
        
        
        
        if adetails.count > 0 {
            let height = adetails.count * 50
            adultTVHeight.constant = CGFloat(height)
        }
        
        self.addAdultTV.reloadData()
        
        
    }
    
    func setupUI() {
        adultTVHeight.constant = 0
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        titleHolderView.backgroundColor = .WhiteColor
        titleHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 0.5)
        
        setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addAdultBtnView, radius: 15, color: .ButtonColor)
        
        travelImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "Traveller Details", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: addlbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 14), align: .center)
        
        setuplabels(lbl: totalNoOfTravellerlbl, text: "No Of Travellers:\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "0")", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .right)
        
        addAdultBtn.setTitle("", for: .normal)
        
    }
    
    
    func setupAdultTV() {
        addAdultTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addAdultTV.delegate = self
        addAdultTV.dataSource = self
        addAdultTV.tableFooterView = UIView()
        addAdultTV.separatorStyle = .none
        addAdultTV.showsHorizontalScrollIndicator = false
        addAdultTV.isScrollEnabled = false
        addAdultTV.allowsMultipleSelection = true
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    
    func didTapOnEditAdultBtn(cell: AddAdultsOrGuestTVCell) {
        delegate?.didTapOnEditTraveller(cell: cell)
    }
    
    func didTapOnOptionBtn(cell:AddAdultsOrGuestTVCell){
        
        if checkBool5 == true {
            
            if (Int(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "0") ?? 0) >= checkOptionCountArray.count {
                checkOptionCountArray.append(cell.travellerId)
            }
            
            cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            checkBool5 = false
        }else {
            if cell.indexPath?.row ?? 0 < checkOptionCountArray.count && !(cell.indexPath?.row ?? 0 < 0) {
                checkOptionCountArray.remove(at: cell.indexPath?.row ?? 0)
            }
            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            checkBool5 = true
        }
        
        print(checkOptionCountArray)
    }
    
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Adult")
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "passenger_type = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            adetails = try context.fetch(request)
            print(adetails)
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        if adetails.count > 0 {
            context.delete(adetails[index] as! NSManagedObject )
            adetails.remove(at: index)
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            self.addAdultTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            updateUI()
            
        }
    }
    
}


extension AddAdultTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adetails.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            
            cell.passengerType = "Adult"
            cell.deleteBtn.tag = indexPath.row
            
            
            let data = adetails as! [NSManagedObject]
            cell.titlelbl.text = data[indexPath.row].value(forKey: "first_name") as? String
            cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
            cell.passengerType = "Adult"
            cell.index = cell.indexPath?.row ?? 0
            cell.deleteBtnView.isHidden = true
            
            if   adetails.count > adultsCount || adetails.count == adultsCount{
                addAdultBtnView.isHidden = true
            }else {
                addAdultBtnView.isHidden = false
            }
            ccell = cell
        }
        
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? AddAdultsOrGuestTVCell {
            cell.isSelected = true
            cell.selected1()
            arrayOf_SelectedCellsAdult.append(indexPath)
            let data = adetails as! [NSManagedObject]
            let passenger = Passenger(
                passengerType: "Adult",
                title2Code: data[indexPath.row].value(forKey: "name_title") as? String ?? "",
                firstName: data[indexPath.row].value(forKey: "first_name") as? String ?? "",
                lastName: data[indexPath.row].value(forKey: "last_name") as? String ?? "",
                dateOfBirth: convertDateFormat(inputDate: data[indexPath.row].value(forKey: "passenger_dob") as? String ?? "", f1: "dd-MM-yyyy", f2: "yyyy/MM/dd"),
                passportNumber: data[indexPath.row].value(forKey: "passenger_passport_number") as? String ?? "",
                passportNationality: data[indexPath.row].value(forKey: "passenger_nationality") as? String ?? "",
                passportIssuingCountry: data[indexPath.row].value(forKey: "passenger_passport_issuing_country") as? String ?? "",
                middleName: "",
                isLeadPassenger: "1",
                gender: (data[indexPath.row].value(forKey: "gender") as? String ?? "") == "Male" ? "1" : ((data[indexPath.row].value(forKey: "gender") as? String ?? "") == "Female" ? "2" : "3"),
                passportExpiryDay: data[indexPath.row].value(forKey: "passenger_passport_expiry_day") as? String ?? "",
                passportExpiryMonth: data[indexPath.row].value(forKey: "passenger_passport_expiry_month") as? String ?? "",
                passportExpiryYear: data[indexPath.row].value(forKey: "passenger_passport_expiry_year") as? String ?? "",
                passenger_passport_expiry_date: convertDateFormat(inputDate: data[indexPath.row].value(forKey: "passenger_passport_expiry_date") as? String ?? "", f1: "dd-MM-yyyy", f2: "yyyy/MM/dd")
            )
            passengerA.append(passenger)
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? AddAdultsOrGuestTVCell {
            cell.isSelected = false
            cell.unselected()
            tableView.deselectRow(at: indexPath, animated: true)
            
            if indexPath.row < passengerA.count {
                passengerA.remove(at: indexPath.row)
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell1 = cell as? AddAdultsOrGuestTVCell
        
        if tableView == addAdultTV {
            if arrayOf_SelectedCellsAdult.contains(indexPath) {
                cell1?.selected1()
                addAdultTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                
            } else {
                cell1?.unselected()
                addAdultTV.deselectRow(at: indexPath, animated: true)
            }
        }
        
        
        
    }
    
    
}

