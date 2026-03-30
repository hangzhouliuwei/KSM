//
//  PKCertificationBasicItemHelper.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//

func transForBirthOrItherDataChange(inTsht dateStr: String, ofcaost: String) -> TimeInterval {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = ofcaost
    guard let date = dateFormatter.date(from: dateStr) else {
        return 0
    }
    return date.timeIntervalSince1970
}
