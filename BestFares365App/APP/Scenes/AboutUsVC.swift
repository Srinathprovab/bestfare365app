//
//  AboutUsVC.swift
//  BestFares365App
//
//  Created by FCI on 10/03/23.
//

import UIKit
import WebKit

class AboutUsVC: BaseTableVC, AboutUsViewModelDelegate {
   

    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var webview: WKWebView!
    
    var tablerow = [TableRow]()
    var str = String()
    var key = String()
    var titleStr = String()
    var urlString = String()
    var viewmodel: AboutUsViewModel?
    static var newInstance: AboutUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AboutUsVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        switch key {
        case "aboutus":
            viewmodel?.CALL_ABOUT_US_API(dictParam: [:], url: "general/cms/Bottom/1")
            break
            
        case "privacy":
            viewmodel?.CALL_ABOUT_US_API(dictParam: [:], url: "general/cms/Bottom/9")
            break
            
            
        case "terms":
            viewmodel?.CALL_ABOUT_US_API(dictParam: [:], url: "general/cms/Bottom/8")
            break
            
            
        case "refund":
            viewmodel?.CALL_ABOUT_US_API(dictParam: [:], url: "general/cms/Bottom/4")
            break
            
        case "cancellation":
            viewmodel?.CALL_ABOUT_US_API(dictParam: [:], url: "general/cms/Bottom/12")
            break
            
            
        case "voucher":
            setuplabels(lbl: nav.titlelbl, text: titleStr, textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
            commonTableView.isHidden = true
            self.webview.isHidden = false
            let url = URL(string: urlString)
            webview.load(URLRequest(url: url!))
            break
            
            
            
        default:
            break
        }
    }
    
    
    func aboutusDetails(response: AboutUsModel) {
        
        response.data?.map({ i in
            str = i.page_description ?? ""
            setuplabels(lbl: nav.titlelbl, text: i.page_title ?? "", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
        })
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = AboutUsViewModel(self)
    }
    

    func setupUI() {
        webview.isHidden = true
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["AboutUsLabelTVCell"])
        
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton){
        dismiss(animated: true)
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:str,cellType:.AboutUsLabelTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }

}
