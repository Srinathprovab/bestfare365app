//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC, CurrencyListViewModelDelegate {
   
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var langUL: UIView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var currencyUL: UIView!
    @IBOutlet weak var currencBtn: UIButton!
    
    static var newInstance: SelectLanguageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectLanguageVC
        return vc
    }
    var tablerow = [TableRow]()
    var onTap = String()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        getCurrencyListAPI()
    }
    
    var viewModel:CurrencyListViewModel?
    var currencyList = [CurrencyListModel]()
    func getCurrencyListAPI() {
        viewModel?.CALL_GET_CURRENCY_LIST_API(dictParam: [:])
    }
    
    
    func currencyList(response: [CurrencyListModel]) {
        currencyList = response
        
        DispatchQueue.main.async {
            self.setupCurencyTVCell()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupUI()
        setupCurrency()
        viewModel = CurrencyListViewModel(self)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
       
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: langView, radius: 3, color: .WhiteColor)
        setupViews(v: currencyView, radius: 3, color: .WhiteColor)
        setupViews(v: langUL, radius: 0, color: .WhiteColor)
        setupViews(v: currencyUL, radius: 0, color: .ButtonColor)
        
        setuplabels(lbl: titlelbl, text: "Select Language /Currency", textcolor: .AppLabelColor, font: .SigvarRegular(size: 18), align: .left)
        setuplabels(lbl: langlbl, text: "Language", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: currencylbl, text: "Currency", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 16), align: .left)
        
        
        langBtn.setTitle("", for: .normal)
        currencBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        
        
        commonTableView.registerTVCells(["SelectLanguageTVCell"])
        
        
        
    }
    
    
    func setuplanguageTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
      //  tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCurencyTVCell() {
        tablerow.removeAll()
        
        currencyList.forEach { i in
            tablerow.append(TableRow(title:i.country_name ?? "",subTitle: i.country ?? "",key:"lang1",buttonTitle: i.currency_symbol ?? "",cellType: .SelectLanguageTVCell))
        }

        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
        setupLanguage()
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        setupCurrency()
    }
    
    
    func setupLanguage() {
        onTap = "language"
        langlbl.textColor = .ButtonColor
        langUL.backgroundColor = .ButtonColor
        
        currencylbl.textColor = .AppLabelColor
        currencyUL.backgroundColor = .WhiteColor
        
        setuplanguageTVCell()
    }
    
    
    func setupCurrency() {
        onTap = "currency"
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .ButtonColor
        currencyUL.backgroundColor = .ButtonColor
        setupCurencyTVCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            if onTap == "currency" {
                defaults.set(cell.subTitlelbl.text ?? "", forKey: UserDefaultsKeys.selectedCurrency)
                defaults.set(cell.currency_symbol, forKey: UserDefaultsKeys.currencysymbol)

            }
            cell.selected()
            gotoHomeVC()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.unselected()
        }
    }
    
    
    
    func gotoHomeVC() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyStr = "SelectLanguageVC"
        self.present(vc, animated: false)
    }
    
    
}
