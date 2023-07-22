//
//  AirlinesFilterTVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit

struct AirlinesData {
    var title: String
    var isSelected: Bool
}



protocol AirlinesFilterTVCellDelegate {
    func showMoreButtonAction(cell:AirlinesFilterTVCell)
    func didSelectAirlines(cell:AirlinesNameTVCell)
    func didDeselectAirlines(cell:AirlinesNameTVCell)
}

class AirlinesFilterTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var airlinesTV: UITableView!
    // @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    //  @IBOutlet weak var showBtnHeight: NSLayoutConstraint!
    
    var airlinesListArray = [String]()
    var airlinesNameArrayCount = 5
    var delegate:AirlinesFilterTVCellDelegate?
    var selectedCells: [IndexPath] = []
    
    
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
        
        airlinesListArray = cellInfo?.moreData as? [String] ?? []
        titlelbl.text = cellInfo?.title
        tvHeight.constant = CGFloat((airlinesListArray.count * 56))
        airlinesTV.reloadData()
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let indexPath = self.indexPath, let index = selectedCells.firstIndex(of: indexPath) {
            selectedCells.remove(at: index)
        }
    }
    
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16))
        setupTV()
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    func setupTV() {
        
        let nib = UINib(nibName: "AirlinesNameTVCell", bundle: nil)
        airlinesTV.register(nib, forCellReuseIdentifier: "cell")
        airlinesTV.delegate = self
        airlinesTV.dataSource = self
        airlinesTV.tableFooterView = UIView()
        airlinesTV.separatorStyle = .none
        airlinesTV.isScrollEnabled = false
        airlinesTV.allowsMultipleSelection = true
        
    }
    
}



extension AirlinesFilterTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return airlinesListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AirlinesNameTVCell {
            cell.filtertitle = cellInfo?.title ?? ""
            if cellInfo?.key == "arriving" {
                cell.hideLogoImage()
                setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16))
            }else if cellInfo?.key == "hide"{
                cell.hideLogoImage()
                setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16))
            }else {
                cell.logoImgWidth.constant = 35
                cell.airlinesLogo.sd_setImage(with: URL(string: airlinesLogoArray[indexPath.row]), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                
            }
            
            cell.titlelbl.text = airlinesListArray[indexPath.row]
            
            
            ccell = cell
        }
        return ccell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AirlinesNameTVCell {
            cell.selected1()
            selectedCells.append(indexPath)
            delegate?.didSelectAirlines(cell: cell)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AirlinesNameTVCell {
            cell.unselected()
            if let index = selectedCells.firstIndex(of: indexPath) {
                selectedCells.remove(at: index)
            }
            delegate?.didDeselectAirlines(cell: cell)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell1 = cell as? AirlinesNameTVCell
        if selectedCells.contains(indexPath) {
            cell1?.selected1()
        } else {
            cell1?.unselected()
        }
    }
    
}
