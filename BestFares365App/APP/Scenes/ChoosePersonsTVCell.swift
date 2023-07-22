//
//  ChoosePersonsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 05/11/22.
//

import UIKit

class ChoosePersonsTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roomCountlbl: UILabel!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var deleteRoomBtn: UIButton!
    @IBOutlet weak var adultsTV: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func prepareForReuse() {
        deleteView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .white
        setuplabels(lbl: roomCountlbl, text: "Room 1", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 16), align: .left)
        deleteView.backgroundColor = .clear
        deleteView.isHidden = true
        deleteImg.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
        deleteRoomBtn.addTarget(self, action: #selector(didTaponDeleteRoomBtn(_:)), for: .touchUpInside)
        setupTV()
    }
    
    func setupTV() {
        adultsTV.register(UINib(nibName: "AddAdultsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        adultsTV.delegate = self
        adultsTV.dataSource = self
        adultsTV.tableFooterView = UIView()
        adultsTV.showsHorizontalScrollIndicator = false
    }
    
    @objc func didTaponDeleteRoomBtn(_ sender:UIButton) {
        print("didTaponDeleteRoomBtn")
    }
    
}


extension ChoosePersonsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = "Adults"
            cell.subTitlelbl.text = "+12 yrs"
            c = cell
        }
        return c
    }
    
}
