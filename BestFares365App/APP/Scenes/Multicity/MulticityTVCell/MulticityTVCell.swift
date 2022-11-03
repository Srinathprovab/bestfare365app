//
//  MulticityTVCell.swift
//  BestFares365App
//
//  Created by FCI on 02/11/22.
//

import UIKit

protocol MulticityTVCellDelegate {
    func didTapOnFromCityBtn(cell:MulticityTVCell)
    func didTapOnToCityBtn(cell:MulticityTVCell)
    func didTapOnDateBtn(cell:MulticityTVCell)
}

class MulticityTVCell: TableViewCell, MulticityFromTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var multicityTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var addMoreBtn: UIButton!
    
    
    var delegate:MulticityTVCellDelegate?
    var count = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        updateheight()
    }
    
    func updateheight() {
        tvHeight.constant = CGFloat(112 * (fromCityNameArray.count))
        multicityTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        addMoreBtn.setTitle("+ Add More", for: .normal)
        addMoreBtn.addTarget(self, action: #selector(didTapOnAddMoreCityBtnAction(_:)), for: .touchUpInside)
        setupTV()
    }
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "MulticityFromTVCell", bundle: nil)
        multicityTV.register(nib, forCellReuseIdentifier: "cell")
        multicityTV.delegate = self
        multicityTV.dataSource = self
        multicityTV.tableFooterView = UIView()
        multicityTV.separatorStyle = .none
        multicityTV.isScrollEnabled = false
        
    }
    
    
    
    @objc func didTapOnAddMoreCityBtnAction(_ sender:UIButton){
        count += 1
        print("count \(count)")
        print("fromCityNameArray count \(fromCityNameArray.count)")
        if fromCityNameArray.count >= 5 {
            //            multicityTV.deleteRows(at: [IndexPath(item: 5, section: 0)], with: .automatic)
            //            multicityTV.reloadData()
            
            addMoreBtn.isHidden = true
            
        }else {
            
            fromCityNameArray.append("Select")
            fromCityShortNameArray.append("City")
            toCityNameArray.append("Select")
            toCityShortNameArray.append("City")
            calDate.append("Select")
            calDateYearArray.append("Date")
            
            
            fromlocidArray.append("")
            tolocidArray.append("")
            fromCityArray.append("")
            toCityArray.append("")
            depatureDatesArray.append("")
            
            // multicityTV.insertRows(at: [IndexPath(item: fromCityNameArray.count, section: 0)], with: .automatic)
            
            DispatchQueue.main.async {[self] in
                updateheight()
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            }
            
            
            if fromCityNameArray.count == 5 {
                addMoreBtn.isHidden = true
            }
            
        }
        
    }
    
    
    
    func didTapOnDeleteCityBtn(cell:MulticityFromTVCell) {
        
        fromCityNameArray.remove(at: cell.deleteBtn.tag)
        fromCityShortNameArray.remove(at: cell.deleteBtn.tag)
        toCityNameArray.remove(at: cell.deleteBtn.tag)
        toCityShortNameArray.remove(at: cell.deleteBtn.tag)
        calDate.remove(at: cell.deleteBtn.tag)
        calDateYearArray.remove(at: cell.deleteBtn.tag)
        
        
        //---------------
        
        depatureDatesArray.remove(at: cell.deleteBtn.tag)
        fromlocidArray.remove(at: cell.deleteBtn.tag)
        tolocidArray.remove(at: cell.deleteBtn.tag)
        fromCityArray.remove(at: cell.deleteBtn.tag)
        toCityArray.remove(at: cell.deleteBtn.tag)
        
        //---------------
        
        multicityTV.deleteRows(at: [IndexPath(item: cell.deleteBtn.tag, section: 0)], with: .automatic)
        DispatchQueue.main.async {[self] in
            if fromCityNameArray.count < 5 {
                addMoreBtn.isHidden = false
            }
        }
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    
    
    @objc func didTapOnFromCityBtn(cell:MulticityFromTVCell) {
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    
    func didTapOnToCityBtn(cell:MulticityFromTVCell){
        defaults.set(cell.toCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    func didTapOnDateBtn(cell:MulticityFromTVCell){
        defaults.set(cell.selectDateBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnDateBtn(cell: self)
    }
    
}



extension MulticityTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromCityNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MulticityFromTVCell {
            
            cell.delegate = self
            cell.fromCityNamelbl.text = fromCityNameArray[indexPath.row]
            cell.fromCityCodelbl.text = fromCityShortNameArray[indexPath.row]
            cell.toCityNamelbl.text = toCityNameArray[indexPath.row]
            cell.toCityCodelbl.text = toCityShortNameArray[indexPath.row]
            cell.dateValuelbl.text = calDate[indexPath.row]
            
            if indexPath.row != 0 && indexPath.row != 1{
                cell.deleteView.isHidden = false
                cell.fromlbl.text = ""
                cell.tolbl.text = ""
                cell.datelbl.text = ""
                cell.deleteBtn.tag = indexPath.row
            }
            
            cell.fromCityBtn.tag = indexPath.row
            cell.toCityBtn.tag = indexPath.row
            cell.selectDateBtn.tag = indexPath.row
            
            
            
            commonCell = cell
        }
        return commonCell
    }
    
}
