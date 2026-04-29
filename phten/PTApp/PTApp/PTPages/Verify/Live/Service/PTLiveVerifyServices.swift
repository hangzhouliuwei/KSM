//
//  PTLiveVerifyServices.swift
//  PTApp
//

import Foundation
import YTKNetwork

@objc(PTInitLiveService)
class PTInitLiveService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(productId),
            path: PTAPIEndpoint.liveInit,
            showLoading: true
        )
    }
}

@objc(PTLimitLiveService)
class PTLimitLiveService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(productId),
            path: PTAPIEndpoint.liveLimit,
            showLoading: true
        )
    }
}

@objc(PTAuthLiveService)
class PTAuthLiveService: PTDictionaryRequest {
    init() {
        super.init(data: PTRequestParameters.empty, path: PTAPIEndpoint.liveLicense, method: .GET, showLoading: true)
    }
}

@objc(PTDetectionLiveService)
class PTDetectionLiveService: PTDictionaryRequest {
    @objc(initWithProductId:liveness_id:)
    init(productId: String?, livenessId: String?) {
        super.init(
            data: PTRequestParameters.product(
                productId,
                extra: [PTAPIParameterKey.livenessId: PTRequestValue.string(livenessId)]
            ),
            path: PTAPIEndpoint.liveDetection,
            showLoading: true
        )
    }
}

@objc(PTSaveLiveService)
class PTSaveLiveService: PTDictionaryRequest {
    @objc(initWithDic:)
    init(dic: NSDictionary?) {
        super.init(data: PTRequestParameters.dictionary(dic), path: PTAPIEndpoint.saveLive, showLoading: true)
    }
}

@objc(PTAuthErrorLiveService)
class PTAuthErrorLiveService: PTDictionaryRequest {
    @objc(initWithError:)
    init(error: String?) {
        super.init(data: [PTAPIParameterKey.liveError: PTRequestValue.string(error)], path: PTAPIEndpoint.liveError)
    }
}
