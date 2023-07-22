//
//  PopupVC.swift
//  BabSafar
//
//  Created by FCI on 06/03/23.
//

import UIKit

class PopupVC: UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var searchBtnView: UIView!
    @IBOutlet weak var searchlbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    static var newInstance: PopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PopupVC
        return vc
    }
    var isFromVc = String()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if isFromVc == "hotel" {
            
            setuplabels(lbl: titlelbl, text: "Cancellation Policy", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .center)
            setuplabels(lbl: subtitlelbl, text: "Thu 16 298379823gsvdgh", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 13), align: .center)
            subtitlelbl.isHidden = false
            setuplabels(lbl: searchlbl, text: "Close", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 14), align: .center)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "Your Session Expired", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .center)
        searchBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        searchBtnView.backgroundColor = .ButtonColor
        setuplabels(lbl: searchlbl, text: "Search Again", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 15), align: .center)
        setuplabels(lbl: subtitlelbl, text: "Search", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 13), align: .center)
        subtitlelbl.isHidden = true
        
        searchBtn.setTitle("", for: .normal)
        searchBtn.addTarget(self, action: #selector(didTapOnSearchFlightAgainBtn(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapOnSearchFlightAgainBtn(_ sender:UIButton) {
        gotoDashboardVC()
    }
    
    
    func gotoDashboardVC() {
       
        if isFromVc == "hotel" {
            dismiss(animated: true)
        }else {
            guard let vc = HomeVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            
        }
    }
    
    
}
