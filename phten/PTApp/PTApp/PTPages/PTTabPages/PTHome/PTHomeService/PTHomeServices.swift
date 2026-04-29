//
//  PTHomeServices.swift
//  PTApp
//

import Foundation
import YTKNetwork

@objc(PTHomeIndexService)
class PTHomeIndexService: PTDictionaryRequest {
    @objc(initWithhomeIndex)
    init() {
        super.init(data: PTRequestParameters.empty, path: PTAPIEndpoint.homeIndex, method: .GET)
    }
}

@objc(PTHomePopApi)
class PTHomePopApi: PTDictionaryRequest {
    init() {
        super.init(data: PTRequestParameters.empty, path: PTAPIEndpoint.homePopup, method: .GET)
    }
}

@objc(PTHomeGCeDetailService)
class PTHomeGCeDetailService: PTDictionaryRequest {
    @objc(initWithProductId:)
    init(productId: String?) {
        super.init(
            data: PTRequestParameters.product(productId),
            path: PTAPIEndpoint.gceDetail,
            showLoading: true
        )
    }
}

@objc(PTHomeGCePushService)
class PTHomeGCePushService: PTDictionaryRequest {
    @objc(initWithOrderId:)
    init(orderId: String?) {
        super.init(
            data: [
                PTAPIParameterKey.orderId: ptValue(orderId),
                PTAPIParameterKey.pushQueue: PTAPIParameterValue.pushQueue,
                PTAPIParameterKey.pushScene: PTAPIParameterValue.pushScene
            ],
            path: PTAPIEndpoint.gcePush
        )
    }
}

@objc(PTHomeGceApplyService)
class PTHomeGceApplyService: PTDictionaryRequest {
    @objc(initWithlitenetusNc:)
    init(litenetusNc: String?) {
        super.init(
            data: PTRequestParameters.product(
                litenetusNc,
                extra: [PTAPIParameterKey.applySource: PTAPIParameterValue.applySource]
            ),
            path: PTAPIEndpoint.gceApply,
            showLoading: true
        )
    }
}
