//
//  PTBankVerifyServices.swift
//  PTApp
//

import Foundation

@objc(PTGetBankService)
class PTGetBankService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(productId),
            path: PTAPIEndpoint.bankInfo,
            showLoading: true
        )
    }
}

@objc(PTSaveBankService)
class PTSaveBankService: PTDictionaryRequest {
    @objc(initWithDic:)
    init(dic: NSDictionary?) {
        super.init(data: PTRequestParameters.dictionary(dic), path: PTAPIEndpoint.saveBankInfo, showLoading: true)
    }
}
