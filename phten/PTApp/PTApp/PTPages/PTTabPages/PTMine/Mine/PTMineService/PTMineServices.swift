//
//  PTMineServices.swift
//  PTApp
//

import Foundation
import YTKNetwork

@objc(PTMineIndexService)
class PTMineIndexService: PTDictionaryRequest {
    @objc(initWithMineIndex)
    init() {
        super.init(data: PTRequestParameters.empty, path: PTAPIEndpoint.mineIndex, method: .GET, showLoading: true)
    }
}

@objc(PTSettLogoutService)
class PTSettLogoutService: PTDictionaryRequest {
    @objc(initWithSettLogout)
    init() {
        super.init(data: PTRequestParameters.empty, path: PTAPIEndpoint.logout, method: .GET, showLoading: true)
    }
}
