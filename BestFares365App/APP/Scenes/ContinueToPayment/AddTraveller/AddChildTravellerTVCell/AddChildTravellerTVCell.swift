//
//  AddChildTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit
import CoreData

protocol AddChildTravellerTVCellDelegate {
    func didTapOnAddChildBtn(cell:AddChildTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddChildTravellerTVCell: TableViewCell, AddAdultsOrGuestTVCellDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var addChildHolderView: UIView!
    @IBOutlet weak var addChildBtnView: UIView!
    @IBOutlet weak var addchildlbl: UILabel!
    @IBOutlet weak var addChildBtn: UIButton!
    @IBOutlet weak var addChildTV: UITableView!
    @IBOutlet weak var addChildTVHeight: NSLayoutConstraint!
    
    
    var childCount = 0
    var delegate:AddChildTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var cdetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupChildTV()
        
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
        fetchAdultCoreDataValues(str: "Children")
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
            }else if journeyType == "circle"{
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
            }else {
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
            }
        }
        
        
        if childCount == 0 {
            addChildHolderView.isHidden = true
            addChildTV.isHidden = true
            addChildTVHeight.constant = 0
        }
        
        
        if cdetails.count == childCount {
            addChildBtnView.isHidden = true
        }
        
        if cdetails.count > 0 {
            let height = cdetails.count * 50
            addChildTVHeight.constant = CGFloat(height)
        }
        
        self.contentView.layoutIfNeeded()
        self.addChildTV.reloadData()
        
        
    }
    
    func setupUI() {
        
        addChildTVHeight.constant = 0
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        
        addChildHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        setupViews(v: addChildHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addChildBtnView, radius: 15, color: .ButtonColor)
        setuplabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: addchildlbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 14), align: .center)
        addChildBtn.setTitle("", for: .normal)
        
        
    }
    
    
    
    
    func setupChildTV() {
        addChildTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addChildTV.delegate = self
        addChildTV.dataSource = self
        addChildTV.tableFooterView = UIView()
        addChildTV.separatorStyle = .none
        addChildTV.showsHorizontalScrollIndicator = false
        addChildTV.isScrollEnabled = false
        addChildTV.allowsMultipleSelection = true
    }
    
    
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppHolderViewColor.cgColor
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
    
    
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Child")
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "passenger_type = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            
            cdetails = try context.fetch(request)
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        if cdetails.count > 0 {
            context.delete(cdetails[index] as! NSManagedObject )
            cdetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            
            self.addChildTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            fetchAdultCoreDataValues(str: "Adult")
            updateUI()
            
        }
    }
    
    
    
}


extension AddChildTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cdetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            
            let data = cdetails as! [NSManagedObject]
            cell.titlelbl.text = data[indexPath.row].value(forKey: "first_name") as? String
            cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
            cell.passengerType = "Child"
            if   cdetails.count > childCount || cdetails.count == childCount{
                addChildBtnView.isHidden = true
            }else {
                addChildBtnView.isHidden = false
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
            let data = cdetails as! [NSManagedObject]
            let passenger = Passenger(
                passengerType: "Child",
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
                passportExpiryYear: data[indexPath.row].value(forKey: "passenger_passport_expiry_year") as? String ?? "", passenger_passport_expiry_date: convertDateFormat(inputDate: data[indexPath.row].value(forKey: "passenger_passport_expiry_date") as? String ?? "", f1: "dd-MM-yyyy", f2: "yyyy/MM/dd")
            )
            passengerA.append(passenger)
            
        }
        
        
        print(passengerA)
        
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
        
        
        if arrayOf_SelectedCellsChild.contains(indexPath) {
            cell1?.selected1()
            addChildTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            
        } else {
            cell1?.unselected()
            addChildTV.deselectRow(at: indexPath, animated: true)
            
        }
        
    }
    
    
    
    
}

