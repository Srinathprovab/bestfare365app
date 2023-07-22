//
//  AddInfantaTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit




import UIKit
import CoreData


protocol AddInfantaTravellerTVCellDelegate {
    func didTapOnAddInfantaBtn(cell:AddInfantaTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
}


class AddInfantaTravellerTVCell: TableViewCell,AddAdultsOrGuestTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addInfantaHolderView: UIView!
    @IBOutlet weak var infantalbl: UILabel!
    @IBOutlet weak var addInfantaBtnView: UIView!
    @IBOutlet weak var addInfantalbl: UILabel!
    @IBOutlet weak var addInfantaBtn: UIButton!
    @IBOutlet weak var addInfantaTV: UITableView!
    @IBOutlet weak var infantaTVHeight: NSLayoutConstraint!
    
    
    var infantsCount = 0
    var delegate:AddInfantaTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var idetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupInfantaTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        
        
    }
    
    
    override func updateUI() {
        checkOptionCountArray.removeAll()
        fetchAdultCoreDataValues(str: "Infantas")
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") ?? 0
            }else if journeyType == "circle"{
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") ?? 0
            }else {
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") ?? 0
            }
        }
        
        
        
        
        if infantsCount == 0 {
            addInfantaHolderView.isHidden = true
            addInfantaTV.isHidden = true
            infantaTVHeight.constant = 0
        }
        
        
        if idetails.count == infantsCount {
            addInfantaBtnView.isHidden = true
        }
        
        
        if idetails.count > 0 {
            let height = idetails.count * 50
            infantaTVHeight.constant = CGFloat(height)
        }
        
        self.addInfantaTV.reloadData()
        
    }
    
    func setupUI() {
        
        infantaTVHeight.constant = 0
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
       
        
        setupViews(v: addInfantaHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addInfantaBtnView, radius: 15, color: .ButtonColor)
        setuplabels(lbl: infantalbl, text: "Infanta", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: addInfantalbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 14), align: .center)
        addInfantaBtn.setTitle("", for: .normal)
        
        
    }
    
    
    
    
    
    func setupInfantaTV() {
        addInfantaTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addInfantaTV.delegate = self
        addInfantaTV.dataSource = self
        addInfantaTV.tableFooterView = UIView()
        addInfantaTV.separatorStyle = .none
        addInfantaTV.showsHorizontalScrollIndicator = false
        addInfantaTV.isScrollEnabled = false
        addInfantaTV.allowsMultipleSelection = true
        
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
            
            if (Int(totalNoOfTravellers) ?? 0) >= checkOptionCountArray.count {
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
    
    
    
    @IBAction func didTapOnAddInfantaBtn(_ sender: Any) {
        delegate?.didTapOnAddInfantaBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Infantas")
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "passenger_type = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            
            idetails = try context.fetch(request)
            
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        if idetails.count > 0 {
            context.delete(idetails[index] as! NSManagedObject )
            idetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            
            self.addInfantaTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            updateUI()
            
        }
    }
    
    
    
}


extension AddInfantaTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            cell.deleteBtn.tag = cell.indexPath?.row ?? 0
            
            let data = idetails as! [NSManagedObject]
            
            
            cell.titlelbl.text = data[indexPath.row].value(forKey: "first_name") as? String
            cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
            cell.passengerType = "Infant"
            if   idetails.count > infantsCount || idetails.count == infantsCount{
                addInfantaBtnView.isHidden = true
            }else {
                addInfantaBtnView.isHidden = false
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
            let data = idetails as! [NSManagedObject]
            let passenger = Passenger(
                passengerType: "Infant",
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
        
        if arrayOf_SelectedCellsInfanta.contains(indexPath) {
            cell1?.selected1()
            addInfantaTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            cell1?.unselected()
            addInfantaTV.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    
    
}
