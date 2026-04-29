//
//  PTOrderServices.swift
//  PTApp
//

import Foundation

@objc(PTOrderAPI)
class PTOrderAPI: PTDictionaryRequest {
    @objc(initWithNumber:page:pageSize:)
    init(status: Int, page: Int, pageSize: Int) {
        super.init(
            data: [
                PTAPIParameterKey.orderStatus: "\(status)",
                PTAPIParameterKey.page: "\(page)",
                PTAPIParameterKey.pageSize: pageSize
            ],
            path: PTAPIEndpoint.orderList,
            showLoading: true
        )
    }
}
