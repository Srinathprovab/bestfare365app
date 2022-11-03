//
//  ContinueToPaymentVC.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class ContinueToPaymentVC: BaseTableVC {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: ContinueToPaymentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContinueToPaymentVC
        return vc
    }
    var tablerow = [TableRow]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    //MARK:- SETUP UI
    func setupUI() {
        
        setuplabels(lbl: nav.titlelbl, text: "Dubai - kuwait", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
        nav.datelbl.isHidden = false
        setuplabels(lbl: nav.datelbl, text: "15 Thu - 3 Adults - Economy", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 20), align: .center)
        nav.titlelbl.textAlignment = .center
        nav.datelbl.textAlignment = .center
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight > 835 {
            navHeight.constant = 150
        }else {
            navHeight.constant = 120
        }
        
        
        
        //MARK:- REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["FlightResultTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "TDetailsLoginTVCell",
                                         "CheckinBaggageTVCell",
                                         "ExtraBaggagesTVCell",
                                         "PassengerDetailsTVCell",
                                         "ContactDetailsTVCell",
                                         "FareSummaryTVCell"])
        setupTVCells()
        
    }
    
    //MARK:- DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    //MARK:- APPEND TABLE VIEW CELLS
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.FlightResultTVCell))
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                
                
                
                break
            case "circle":
                
                break
            case "multicity":
                
                break
            default:
                break
            }
        }
        
        tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        tablerow.append(TableRow(cellType:.CheckinBaggageTVCell))
        tablerow.append(TableRow(cellType:.ExtraBaggagesTVCell))
        tablerow.append(TableRow(cellType:.PassengerDetailsTVCell))
        tablerow.append(TableRow(cellType:.ContactDetailsTVCell))
        tablerow.append(TableRow(cellType:.FareSummaryTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func didTapOnSelectPassengerBtn(cell: ExtraBaggagesTVCell) {
        print("didTapOnSelectPassengerBtn")
    }
    
    override func didTapOnAddPassangerBtnAction(cell: PassengerDetailsTVCell) {
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "show"
        present(vc, animated: true)
    }
    
    override func didTapOnEditPassengerBtn(cell:PassengerDetailsTVCell){
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "edit"
        present(vc, animated: true)
    }
    
    override func editingChanged(tf: UITextField) {
        print(tf.tag)
    }
    
    override func didTapoNCountryCodeBtn(cell: ContactDetailsTVCell) {
        print("didTapoNCountryCodeBtn")
    }
    
    
    @objc func didTaponContinueToPaymentButton(_ sender:UIButton) {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
}


extension ContinueToPaymentVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell =  Bundle.main.loadNibNamed("ButtonTVCell", owner: self, options: nil)?.first as! ButtonTVCell
        setuplabels(lbl: cell.titlelbl, text: "Continue To Payment", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        cell.btnView.backgroundColor = .ButtonColor
        cell.btn.addTarget(self, action: #selector(didTaponContinueToPaymentButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
}
