//
//  ShowFlightDetailsVC.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class ShowFlightDetailsVC: BaseTableVC {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var cityCodeslbl: UILabel!
    @IBOutlet weak var clkImg: UIImageView!
    @IBOutlet weak var hourlbl: UILabel!
    
    static var newInstance: ShowFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ShowFlightDetailsVC
        return vc
    }
    
    
    var tablerow = [TableRow]()
    
    //MARK:- VIEW LOADING FUNCTION
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
        
        setuplabels(lbl: cityCodeslbl, text: "DXB - KWI", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20), align: .left)
        setuplabels(lbl: hourlbl, text: "14h 25min", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16), align: .left)
        clkImg.image = UIImage(named: "clk")?.withRenderingMode(.alwaysOriginal)
        
        
        //MARK:- REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["BaggageTVCell","BottomBookNowTVCell","FareRulesTVCell","EmptyTVCell","FlightDetailTVCell"])
        setupTVCells()
        
    }
    
    
    //MARK:- DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    
   
    //MARK:- APPEND TABLE VIEW CELLS
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.FlightDetailTVCell))
        tablerow.append(TableRow(cellType:.FareRulesTVCell))
        tablerow.append(TableRow(cellType:.BaggageTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnMoreButton(cell: FareRulesTVCell) {
        print("didTapOnMoreButton")
        cell.moreBtn.isHidden = true
    }
    
    
    @objc func didTapOnBookNowButton(_ sender:UIButton){
        guard let vc = ContinueToPaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
}



extension ShowFlightDetailsVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell =  Bundle.main.loadNibNamed("BottomBookNowTVCell", owner: self, options: nil)?.first as! BottomBookNowTVCell
        cell.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 88
    }
    
}
