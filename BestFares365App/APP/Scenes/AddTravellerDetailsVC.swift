//
//  AddTravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import CoreData

class AddTravellerDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    
    var keyStr = String()
    var tablerow = [TableRow]()
    var key = String()
    var id = String()
    var passenger_dob = String()
    var passenger_type = String()
    var lead_passenger = "1"
    var gender = String()
    var passenger_nationality = String()
    var name_title = String()
    var first_name = String()
    var last_name = String()
    var passenger_passport_number = String()
    var passenger_passport_issuing_country = String()
    var passenger_passport_expiry_date = String()
    var passenger_passport_expiry_day = String()
    var passenger_passport_expiry_month = String()
    var passenger_passport_expiry_year = String()
    
    
    
    static var newInstance: AddTravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellerDetailsVC
        return vc
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        callApi()
    }
    
    func  callApi(){
        if key == "edit" {
            fetchCoreDataValues(id1: id)
        }
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        //        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .overCurrentContext
        //        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if selectedTab == "Flight" {
                navBar.titlelbl.text = "Traveller Details"
                setupTV()
            }else {
                navBar.titlelbl.text = "Guest Details"
                setupHotelAddGuestTV()
            }
        }
        
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TextfieldTVCell",
                                         "DropDownTVCell",
                                         "LabelTVCell",
                                         "EmptyTVCell",
                                         "SelectGenderTVCell",
                                         "ButtonTVCell"])
    }
    
    func setupTV() {
        
        tablerow.removeAll()
        
        if key == "edit" {
            
            tablerow.append(TableRow(title:gender,key:"gender",cellType:.SelectGenderTVCell))
            tablerow.append(TableRow(title:"Frist Name",subTitle: first_name,key: "email",text: "1", buttonTitle: name_title,key1: "fname",isOptional: true,tempText: "Frist Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Last Name",subTitle: last_name,key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Date Of Birth",subTitle: passenger_dob,key: "dob", text: "3",tempText: "22-12-1995",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
            tablerow.append(TableRow(title:"Passport Number",subTitle: passenger_passport_number,key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Issuing Country",subTitle: passenger_passport_issuing_country,key:"issuingcountry", buttonTitle: "Country",image: "downarrow",moreData: phoneCodeArray,cellType:.DropDownTVCell))
            tablerow.append(TableRow(title:"Passport Expiry Date",subTitle:passenger_passport_expiry_date,key: "cal", text: "5", image:"cal",tempText: "Passport Expiry Date",cellType:.TextfieldTVCell))
            
            
            
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Update",bgColor: .ButtonColor,cellType:.ButtonTVCell))
            tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
            
        }else {
            
            tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
            tablerow.append(TableRow(title:"Frist Name",subTitle: "",key: "email",text: "1",key1: "fname", isOptional: false,tempText: "Frist Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Last Name",subTitle: "",key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Date Of Birth",subTitle: "",key: "dob", text: "3",tempText: "22-12-1995",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
            tablerow.append(TableRow(title:"Passport Number",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Issuing Country",subTitle: "Country",image: "downarrow",moreData: phoneCodeArray,cellType:.DropDownTVCell))
            tablerow.append(TableRow(title:"Passport Expiry Date",subTitle:"",key: "cal", text: "5", image:"cal",tempText: "Passport Expiry Date",cellType:.TextfieldTVCell))
            
            
            
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"save",bgColor: .ButtonColor,cellType:.ButtonTVCell))
            tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
            
        }
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func donedatePicker(cell: TextfieldTVCell) {
        passenger_passport_expiry_day = convertDateFormat(inputDate: cell.txtField.text ?? "", f1: "dd-MM-yyyy", f2: "dd")
        passenger_passport_expiry_month = convertDateFormat(inputDate: cell.txtField.text ?? "", f1: "dd-MM-yyyy", f2: "MM")
        passenger_passport_expiry_year = convertDateFormat(inputDate: cell.txtField.text ?? "", f1: "dd-MM-yyyy", f2: "yyyy")
        print(passenger_passport_expiry_day)
        print(passenger_passport_expiry_month)
        print(passenger_passport_expiry_year)
        passenger_passport_expiry_date = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    
    
    override func doneDobdatePicker(cell: TextfieldTVCell) {
        self.passenger_dob = cell.txtField.text ?? ""
        print(passenger_dob)
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: TextfieldTVCell) {
        self.view.endEditing(true)
    }
    
    
    override func didTapOnIssuingCountryDropDownBtn(cell: DropDownTVCell) {
        self.passenger_passport_issuing_country = cell.pass_isssung_country_code
        self.passenger_nationality = cell.pass_nationality
        print(passenger_passport_issuing_country)
    }
    
    
    func setupHotelAddGuestTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",subTitle: "",key: "email", text: "1",tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: "",key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Date Of Birth",subTitle: "",key: "dob", text: "3",tempText: "22-12-1995",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Passport Number",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Issuing Country",subTitle: "Country",image: "downarrow",moreData: phoneCodeArray,cellType:.DropDownTVCell))
        tablerow.append(TableRow(title:"Passport Expiry Date",subTitle:"",key: "cal", text: "5", image:"cal",tempText: "Passport Expiry Date",cellType:.TextfieldTVCell))
        
        
        
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"save",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf:UITextField) {
        switch tf.tag {
        case 1:
            self.first_name = tf.text ?? ""
            break
            
        case 2:
            self.last_name = tf.text ?? ""
            break
            
        case 4:
            self.passenger_passport_number = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    override func didTapOnDropDownBtn(cell:DropDownTVCell){
        switch cell.titlelbl.text {
            
        case "Issuing Country":
            self.passenger_passport_issuing_country = cell.dropdownlbl.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    
    override func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {
        gender = "Male"
        
    }
    
    override func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {
        gender = "Female"
        
    }
    
    override func didSelectOnOthersBtn(cell: SelectGenderTVCell) {
        gender = "Others"
    }
    
    
    
    override func selectedTitle(cell: TextfieldTVCell) {
        switch cell.fnameTitlelbl.text {
        case "Mr":
            name_title = "1"
            break
            
        case "Mrs":
            name_title = "2"
            break
            
        case "Miss":
            name_title = "3"
            break
            
        case "M":
            name_title = "4"
            break
            
            
        default:
            break
        }
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        
        if gender == "" {
            showToast(message: "Select Gender")
        }else if first_name == "" {
            showToast(message: "Enter First Name")
        }else if last_name == "" {
            showToast(message: "Enter Last Name")
        }else if passenger_dob == "" {
            showToast(message: "Enter Date Of Birth")
        }else if passenger_passport_number == "" {
            showToast(message: "Enter Passport Number")
        }else if passenger_passport_number.isValidPassport() == false {
            showToast(message: "Enter Valid Passport No")
        }else if passenger_passport_issuing_country == "" {
            showToast(message: "Select Issuing Country")
        }else if passenger_passport_expiry_date == "" {
            showToast(message: "Select Passport Expiry Date")
        }else {
            
            
         
            
            if key == "edit" {
                update()
            }else {
                saveDetailsLocally()
            }
            
        }
    }
    
    
    
    func gotoContinueToPaymentVC() {
        guard let vc = ContinueToPaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - SAVE COREDATA VALUES
    func saveDetailsLocally() {
        let rno = Int.random(in: 0...500)
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("\(rno)", forKey: "id")
        newUser.setValue(name_title, forKey: "name_title")
        newUser.setValue(passenger_type, forKey: "passenger_type")
        newUser.setValue(lead_passenger, forKey: "lead_passenger")
        newUser.setValue(gender, forKey: "gender")
        newUser.setValue(passenger_dob, forKey: "passenger_dob")
        newUser.setValue(first_name, forKey: "first_name")
        newUser.setValue(last_name, forKey: "last_name")
        newUser.setValue(passenger_passport_number, forKey: "passenger_passport_number")
        newUser.setValue(passenger_passport_expiry_day, forKey: "passenger_passport_expiry_day")
        newUser.setValue(passenger_passport_expiry_month, forKey: "passenger_passport_expiry_month")
        newUser.setValue(passenger_passport_expiry_year, forKey: "passenger_passport_expiry_year")
        newUser.setValue(passenger_passport_issuing_country, forKey: "passenger_passport_issuing_country")
        newUser.setValue(passenger_nationality, forKey: "passenger_nationality")
        newUser.setValue(passenger_passport_expiry_date, forKey: "passenger_passport_expiry_date")
        
        
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
        
        callapibool = false
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues(id1:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        request.predicate = NSPredicate(format: "id = %@", id1)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            print(result)
            details = result
            
            for data in result as! [NSManagedObject]{
                print("fname ====== >\((data.value(forKey: "first_name") as? String) ?? "")")
                
                edit_lead_passenger = (data.value(forKey: "lead_passenger") as? String) ?? ""
                edit_passenger_type = (data.value(forKey: "passenger_type") as? String) ?? ""
                edit_title1 = (data.value(forKey: "name_title") as? String) ?? ""
                edit_fname = (data.value(forKey: "first_name") as? String) ?? ""
                edit_lname = (data.value(forKey: "last_name") as? String) ?? ""
                edit_gender = (data.value(forKey: "gender") as? String) ?? ""
                edit_dob = (data.value(forKey: "passenger_dob") as? String) ?? ""
                edit_nationalitycode = (data.value(forKey: "passenger_nationality") as? String) ?? ""
                edit_passportno = (data.value(forKey: "passenger_passport_number") as? String) ?? ""
                edit_issuingCountrycode = (data.value(forKey: "passenger_passport_issuing_country") as? String) ?? ""
                edit_passenger_passport_expiry_day = (data.value(forKey: "passenger_passport_expiry_day") as? String) ?? ""
                edit_passenger_passport_expiry_month = (data.value(forKey: "passenger_passport_expiry_month") as? String) ?? ""
                edit_passenger_passport_expiry_year = (data.value(forKey: "passenger_passport_expiry_year") as? String) ?? ""
                edit_passenger_passport_expiry_date = (data.value(forKey: "passenger_passport_expiry_date") as? String) ?? ""
                
                self.lead_passenger = edit_lead_passenger
                self.passenger_type = edit_passenger_type
                self.name_title = edit_title1
                self.first_name = edit_fname
                self.last_name = edit_lname
                self.passenger_dob = edit_dob
                self.gender = edit_gender
                self.passenger_passport_number = edit_passportno
                self.passenger_passport_expiry_day = edit_passenger_passport_expiry_day
                self.passenger_passport_expiry_month = edit_passenger_passport_expiry_month
                self.passenger_passport_expiry_year = edit_passenger_passport_expiry_year
                self.passenger_passport_issuing_country = edit_issuingCountryname
                self.passenger_nationality = edit_nationalityname
                self.passenger_passport_expiry_date = edit_passenger_passport_expiry_date
                
            }
            
            DispatchQueue.main.async {[self] in
                setupTV()
            }
        } catch {
            print("Failed")
        }
    }
    
    
    
    
    
    //MARK: - UPDATING COREDATA VALUES
    
    func update(){
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(id = %@)", id)
        request.predicate = predicate
        do {
            let results = try context.fetch(request)
            let newUser = results[0] as! NSManagedObject
            
            newUser.setValue(name_title, forKey: "name_title")
            newUser.setValue(passenger_type, forKey: "passenger_type")
            newUser.setValue(lead_passenger, forKey: "lead_passenger")
            newUser.setValue(gender, forKey: "gender")
            newUser.setValue(passenger_dob, forKey: "passenger_dob")
            newUser.setValue(first_name, forKey: "first_name")
            newUser.setValue(last_name, forKey: "last_name")
            newUser.setValue(passenger_passport_number, forKey: "passenger_passport_number")
            newUser.setValue(passenger_passport_expiry_day, forKey: "passenger_passport_expiry_day")
            newUser.setValue(passenger_passport_expiry_month, forKey: "passenger_passport_expiry_month")
            newUser.setValue(passenger_passport_expiry_year, forKey: "passenger_passport_expiry_year")
            newUser.setValue(passenger_passport_issuing_country, forKey: "passenger_passport_issuing_country")
            newUser.setValue(passenger_nationality, forKey: "passenger_nationality")
            newUser.setValue(passenger_passport_expiry_date, forKey: "passenger_passport_expiry_date")
            
            do {
                try context.save()
                
            }catch let error as NSError {
                print("Failed")
            }
        }
        catch let error as NSError {
            print("Failed")
        }
        
        
        callapibool = false
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
}
