//
//  PTBasicVerifyServices.swift
//  PTApp
//

import Foundation

@objc(PTBasicVerifyService)
class PTBasicVerifyService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(
                productId,
                extra: [PTAPIParameterKey.basicFlag: PTAPIParameterValue.basicFlag]
            ),
            path: PTAPIEndpoint.basicInfo,
            showLoading: true
        )
    }
}

@objc(PTSaveBasicVerifyService)
class PTSaveBasicVerifyService: PTDictionaryRequest {
    @objc(initWithDic:)
    init(dic: NSDictionary?) {
        super.init(data: PTRequestParameters.dictionary(dic), path: PTAPIEndpoint.saveBasicInfo, showLoading: true)
    }
}
