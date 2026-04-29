//
//  PTIdentifyVerifyServices.swift
//  PTApp
//

import Foundation

@objc(PTGetIdentifyService)
class PTGetIdentifyService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(productId),
            path: PTAPIEndpoint.identifyInfo,
            showLoading: true
        )
    }
}

@objc(PTSaveIdentifyService)
class PTSaveIdentifyService: PTDictionaryRequest {
    @objc(initWithDic:)
    init(dic: NSDictionary?) {
        super.init(data: PTRequestParameters.dictionary(dic), path: PTAPIEndpoint.saveIdentifyInfo, showLoading: true)
    }
}
