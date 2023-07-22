//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SideMenuVC: BaseTableVC {
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupMenuTVCells()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .left
        self.view.addGestureRecognizer(swipeDown)
        
        
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell","MenuTVCell","EmptyTVCell"])
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .left:
                dismiss(animated: false)
            default:
                break
            }
        }
    }
    
    
    
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"My Bookings",key: "menu", image: "bookings",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Free Cancellation",key: "menu", image: "feecancel",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Customer Support",key: "menu", image: "customer",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Our Products",key: "ourproducts", image: "",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Flights",key: "menu", image: "bookings",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Hotels",key: "menu", image: "hotel",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Holiday",key: "menu", image: "insurence",cellType:.MenuTVCell))
        tablerow.append(TableRow(height:200,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Logout",key: "menu", image: "logout",cellType:.MenuTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
    //        guard let vc = EditProfileVC.newInstance.self else {return}
    //        vc.modalPresentationStyle = .overCurrentContext
    //        present(vc, animated: true)
    //    }
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        print("")
    }
    
    
    
}



extension SideMenuVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MenuTVCell {
            print(cell.titlelbl.text)
            switch cell.titlelbl.text {
            case "My Bookings":
                
                break
                
            case "Flights":
                
                break
                
            case "Hotels":
                
                break
                
            case "Insurance":
                
                break
                
            case "Visa":
                
                break
                
            default:
                break
            }
        }
    }
    
    
}
