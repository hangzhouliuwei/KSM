//
//  PTLoginServices.swift
//  PTApp
//

import Foundation

@objc(PTLoginGetSMSCodeService)
class PTLoginGetSMSCodeService: PTDictionaryRequest {
    @objc(initWithPhoneNumber:)
    init(phoneNumber: String?) {
        super.init(
            data: [
                PTAPIParameterKey.phoneNumber: ptValue(phoneNumber),
                PTAPIParameterKey.smsType: PTAPIParameterValue.smsType
            ],
            path: PTAPIEndpoint.loginCode,
            showLoading: true
        )
    }
}

@objc(PTLoginService)
class PTLoginService: PTDictionaryRequest {
    @objc(initWithPhoneDataDic:)
    init(phoneDataDic dataDic: NSDictionary?) {
        super.init(data: PTRequestParameters.dictionary(dataDic), path: PTAPIEndpoint.login, showLoading: true)
    }
}
