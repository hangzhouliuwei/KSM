//
//  PTAuthenticationServices.swift
//  PTApp
//

import Foundation

@objc(PTAuthenTicationSerive)
class PTAuthenTicationSerive: PTDictionaryRequest {
    @objc(initWithlitenetusNc:)
    init(litenetusNc: String?) {
        super.init(
            data: PTRequestParameters.product(litenetusNc),
            path: PTAPIEndpoint.gceDetail,
            showLoading: true
        )
    }
}
