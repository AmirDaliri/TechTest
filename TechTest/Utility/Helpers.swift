//
//  Helpers.swift
//  TechTest
//
//  Created by Amir Daliri on 21.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    
    // MARK: - Date Methode
    
    static func convertDateFormatter(date: String? ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"// string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        guard let validDate = date else {return " "}
        let convertedDate = dateFormatter.date(from: validDate)
        
        guard dateFormatter.date(from: validDate) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "EEEE yyyy MMM HH:mm"/// convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        
        return timeStamp
    }
    
    
    // MARK: - Share Question Methode
    
    static func shareQuestion(id: Int ,question: String, image: UIImage, vc: UIViewController) {
        let text = question
        let image = image
        let myWebsite = URL(string:"https://private-anon-c03696cbf4-blissrecruitmentapi.apiary-mock.com/questions/\(id)")
        let shareAll = [text , image , myWebsite!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = vc.view
        vc.present(activityViewController, animated: true, completion: nil)
    }
}
