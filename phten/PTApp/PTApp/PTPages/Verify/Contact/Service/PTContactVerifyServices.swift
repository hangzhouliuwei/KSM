//
//  PTContactVerifyServices.swift
//  PTApp
//

import Foundation

@objc(PTGetContactService)
class PTGetContactService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(
                productId,
                extra: [PTAPIParameterKey.contactFlag: PTAPIParameterValue.contactFlag]
            ),
            path: PTAPIEndpoint.contactInfo,
            showLoading: true
        )
    }
}

@objc(PTSaveContactService)
class PTSaveContactService: PTDictionaryRequest {
    @objc(initWithDic:)
    init(dic: NSDictionary?) {
        super.init(data: PTRequestParameters.dictionary(dic), path: PTAPIEndpoint.saveContactInfo, showLoading: true)
    }
}
