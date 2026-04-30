//
//  XTRequestCenter+Location.swift
//  XTApp
//
//  Created by Codex on 2026/4/30.
//

import Foundation

extension XTRequestCenter {
    @objc(xt_location:)
    func xt_location(_ block: XTBoolBlock?) {
        let locationManager = XTLocationManager.shared
        guard locationManager.xt_startLocation() else {
            block?(false)
            return
        }

        locationManager.lbsInfoBlock = { infoDic, isSuccess in
            guard isSuccess else {
                block?(false)
                return
            }

            let api = XTLocationApi(dic: xtLocationPayload(from: infoDic))
            api.xt_startRequestSuccess { _, _ in
                block?(true)
            } failure: { _, _ in
                block?(false)
            } error: { _ in
                block?(false)
            }
        }
    }
}