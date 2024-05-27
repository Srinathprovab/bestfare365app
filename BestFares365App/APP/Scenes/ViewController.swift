//
//  ViewController.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit

func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}


//MARK: - convert Date Format
func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = f1
    
    guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
    
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = f2
    
    return convertDateFormatter.string(from: oldDate)
}

let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)

//MARK: - check Departure And Return Dates
func checkDepartureAndReturnDates1(_ parameters: [String: Any],p1:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr)
           else {
        print("Invalid date format")
        return false
    }

    let calendar = Calendar.current
    let currentDate = Date()

    if calendar.isDateInTomorrow(departureDate) {
        print("Departure is tomorrow's date")
        return true
    } else if departureDate > currentDate {
        print("Departure is a future date")
        return true
    } else {
        print("Departure is not a future or tomorrow's date")
        return false
    }

    
}


//MARK: - check Departure And Return Dates
func checkDepartureAndReturnDates(_ parameters: [String: Any],p1:String,p2:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let returnDateStr = parameters[p2] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr),
          let returnDate = dateFormatter.date(from: returnDateStr) else {
        print("Invalid date format")
        return false
    }

    let calendar = Calendar.current
    let currentDate = Date()

    if calendar.isDateInTomorrow(departureDate) {
        print("Departure is tomorrow's date")
        return true
    } else if departureDate > currentDate {
        print("Departure is a future date")
        return true
    } else {
        print("Departure is not a future or tomorrow's date")
        return false
    }

    if calendar.isDateInTomorrow(returnDate) {
        print("Return is tomorrow's date")
        return true
    } else if returnDate > currentDate {
        print("Return is a future date")
        return true
    } else {
        print("Return is not a future or tomorrow's date")
        return false
    }
}




class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("screen height :\(screenHeight)")
        print("screenWidth :\(screenWidth)")
       deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        print("deviceId deviceId \(deviceId)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.gotodashBoardScreen()
        })
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyStr = "ViewController"
        vc.defaultsclearKey = "clear"
        present(vc, animated: true)
    }
    
    
}


protocol TimerManagerDelegate: AnyObject {
    func timerDidFinish()
    func updateTimer()
}


class TimerManager {
    static let shared = TimerManager() // Singleton instance
    weak var delegate: TimerManagerDelegate?

    var timerDidFinish = false
    var timer: Timer?
    var totalTime = 1
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    private init() {}


    func startTimer(time:Int) {
        endBackgroundTask() // End any existing background task (if any)
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }

        // Reset the totalTime to its initial value (e.g., 60 seconds)
        totalTime = time

        // Schedule the timer in the common run loop mode
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }


    @objc func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            delegate?.updateTimer()
        } else {
            sessionStop()
            delegate?.timerDidFinish()
            endBackgroundTask()
        }
    }

    @objc func sessionStop() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }

    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }


    private func endBackgroundTask() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}

