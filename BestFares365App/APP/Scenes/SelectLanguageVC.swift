//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupUI()
        setuplanguageTVCell()
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
        setupViews(v: langUL, radius: 0, color: .ButtonColor)
        setupViews(v: currencyUL, radius: 0, color: .WhiteColor)
        
        setuplabels(lbl: titlelbl, text: "Select Language /Currency", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 18), align: .left)
        setuplabels(lbl: langlbl, text: "Language", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: currencylbl, text: "Currency", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 16), align: .left)
        
        
        langBtn.setTitle("", for: .normal)
        currencBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        
        
        commonTableView.registerTVCells(["SelectLanguageTVCell"])
        
    }
    
    
    func setuplanguageTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
        tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCurencyTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "$",key:"lang1",cellType: .SelectLanguageTVCell))
        tablerow.append(TableRow(title:"Arabic",subTitle: "KWD",key:"lang1",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
        langlbl.textColor = .ButtonColor
        langUL.backgroundColor = .ButtonColor
        
        currencylbl.textColor = .LabelTitleColor
        currencyUL.backgroundColor = .WhiteColor
        
        setuplanguageTVCell()
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        langlbl.textColor = .LabelTitleColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .ButtonColor
        currencyUL.backgroundColor = .ButtonColor
        setupCurencyTVCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.selected()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.unselected()
        }
    }
    
    
}
