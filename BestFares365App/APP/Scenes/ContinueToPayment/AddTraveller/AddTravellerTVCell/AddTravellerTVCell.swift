//
//  AddTravellerTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import CoreData


protocol AddTravellerTVCellDelegate {
    
    
    func didTapOnAddAdultBtn(cell:AddTravellerTVCell)
    func didTapOnAddChildBtn(cell:AddTravellerTVCell)
    func didTapOnAddInfantaBtn(cell:AddTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    
    
}


class AddTravellerTVCell: TableViewCell,AddAdultsOrGuestTVCellDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var travelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var totalNoOfTravellerlbl: UILabel!
    
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addChildHolderView: UIView!
    @IBOutlet weak var addChildBtnView: UIView!
    @IBOutlet weak var addchildlbl: UILabel!
    @IBOutlet weak var addChildBtn: UIButton!
    @IBOutlet weak var addChildTV: UITableView!
    @IBOutlet weak var addChildTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addChildHolderViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addInfantaHolderView: UIView!
    @IBOutlet weak var infantalbl: UILabel!
    @IBOutlet weak var addInfantaBtnView: UIView!
    @IBOutlet weak var addInfantalbl: UILabel!
    @IBOutlet weak var addInfantaBtn: UIButton!
    @IBOutlet weak var addInfantaTV: UITableView!
    @IBOutlet weak var infantaTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addInfantaHolderViewHeight: NSLayoutConstraint!
    
    
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var delegate:AddTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var adetails  = [NSFetchRequestResult]()
    var cdetails  = [NSFetchRequestResult]()
    var idetails  = [NSFetchRequestResult]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        setupChildTV()
        setupInfantaTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func updateUI() {
        
        
        details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
        fetchAdultCoreDataValues(str: "Adult")
        fetchAdultCoreDataValues(str: "Children")
        fetchAdultCoreDataValues(str: "Infantas")
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.lapinfants) ?? "0") ?? 0
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rlapinfants) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.mlapinfants) ?? "0") ?? 0
            }
        }
        
        
        if childCount == 0 {
            addChildHolderView.isHidden = true
            addChildTV.isHidden = true
            addChildTVHeight.constant = 0
            addChildHolderViewHeight.constant = 0
        }
        
        if infantsCount == 0 {
            addInfantaHolderView.isHidden = true
            addInfantaTV.isHidden = true
            infantaTVHeight.constant = 0
            addInfantaHolderViewHeight.constant = 0
        }
        
        
        
        if cdetails.count == childCount {
            addChildBtnView.isHidden = true
        }
        
        if idetails.count == infantsCount {
            addInfantaBtnView.isHidden = true
        }
        
        
        
        if adetails.count > 0 {
            let height = adetails.count * 50
            adultTVHeight.constant = CGFloat(height)
        }
        
        
        if cdetails.count > 0 {
            let height = cdetails.count * 50
            addChildTVHeight.constant = CGFloat(height)
        }
        
        
        if idetails.count > 0 {
            let height = idetails.count * 50
            infantaTVHeight.constant = CGFloat(height)
        }
        
        
        
        
        self.contentView.layoutIfNeeded()
        self.addAdultTV.reloadData()
        self.addChildTV.reloadData()
        self.addInfantaTV.reloadData()
        
        
        
        switch cellInfo?.key {
        case "hotel":
            travelImg.image = UIImage(named: "travel")
            titlelbl.text = cellInfo?.title
            totalNoOfTravellerlbl.text = cellInfo?.subTitle
        default:
            break
        }
        
    }
    
    func setupUI() {
        adultTVHeight.constant = 0
        addChildTVHeight.constant = 0
        infantaTVHeight.constant = 0
        
        contentView.backgroundColor = .AppBorderColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: titleHolderView, radius: 0, color: .WhiteColor)
        titleHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addAdultHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addChildHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addInfantaHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        
        
        setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addChildHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addInfantaHolderView, radius: 0, color: .WhiteColor)
        
        setupViews(v: addAdultBtnView, radius: 15, color: .ButtonColor)
        setupViews(v: addChildBtnView, radius: 15, color: .ButtonColor)
        setupViews(v: addInfantaBtnView, radius: 15, color: .ButtonColor)
        
        // setupViews(v: adultTVView, radius: 0, color: .green)
        
        travelImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: titlelbl, text: "Passenger Details", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16))
        setupLabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: infantalbl, text: "Infanta", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        
        setupLabels(lbl: addlbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: addchildlbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: addInfantalbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 14))
        
        setupLabels(lbl: totalNoOfTravellerlbl, text: "", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 12))
        
        addAdultBtn.setTitle("", for: .normal)
        addChildBtn.setTitle("", for: .normal)
        addInfantaBtn.setTitle("", for: .normal)
        
        
    }
    
    
    func setupAdultTV() {
        addAdultTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addAdultTV.delegate = self
        addAdultTV.dataSource = self
        addAdultTV.tableFooterView = UIView()
        addAdultTV.separatorStyle = .none
        addAdultTV.showsHorizontalScrollIndicator = false
    }
    
    func setupChildTV() {
        addChildTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        addChildTV.delegate = self
        addChildTV.dataSource = self
        addChildTV.tableFooterView = UIView()
        addChildTV.separatorStyle = .none
        addChildTV.showsHorizontalScrollIndicator = false
    }
    
    
    func setupInfantaTV() {
        addInfantaTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        addInfantaTV.delegate = self
        addInfantaTV.dataSource = self
        addInfantaTV.tableFooterView = UIView()
        addInfantaTV.separatorStyle = .none
        addInfantaTV.showsHorizontalScrollIndicator = false
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func didTapOnEditAdultBtn(cell: AddAdultsOrGuestTVCell) {
        delegate?.didTapOnEditTraveller(cell: cell)
    }
    
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddInfantaBtn(_ sender: Any) {
        delegate?.didTapOnAddInfantaBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
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
                cdetails = try context.fetch(request)
            }else {
                idetails = try context.fetch(request)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
}


extension AddTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == addAdultTV {
            return adetails.count
        }else if tableView == addChildTV{
            return cdetails.count
        }else {
            return idetails.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if tableView == addAdultTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                let data = adetails as! [NSManagedObject]
                cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                //  cell.editBtn.addTarget(self, action: #selector(didTapOnEditAdultBtn(_:)), for: .touchUpInside)
                cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                if adetails.count == adultsCount {
                    addAdultBtnView.isHidden = true
                }
                
                ccell = cell
            }
            
        }else if tableView == addChildTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                let data = cdetails as! [NSManagedObject]
                cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                //    cell.editBtn.addTarget(self, action: #selector(didTapOnEditChildtBtn(_:)), for: .touchUpInside)
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                let data = idetails as! [NSManagedObject]
                cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                //     cell.editBtn.addTarget(self, action: #selector(didTapOnEditChildtBtn(_:)), for: .touchUpInside)
                ccell = cell
            }
        }
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
