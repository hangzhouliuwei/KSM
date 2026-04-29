//
//  XTFirstViewModel.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

final class FirstViewModel {
    private(set) var indexModel: IndexModel?

    struct ApplyResult {
        let uploadType: Int
        let url: String
        let isList: Bool
    }

    func getFirstSuccess(_ success: XTBlock?, failure: XTBlock?) {
        NetworkService.shared.fetchIndex { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                guard let data = response.data,
                      let jsonData = try? JSONSerialization.data(withJSONObject: data),
                      let model = try? JSONDecoder().decode(IndexModel.self, from: jsonData) else {
                    failure?()
                    return
                }
                self.indexModel = model
                success?()
            case .failure:
                failure?()
            }
        }
    }

    func xt_popUpSuccess(_ success: ((String, String, String) -> Void)?, failure: XTBlock?) {
        NetworkService.shared.fetchPopUp { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    failure?()
                    return
                }
                success?(
                    XT_Object_To_Stirng(data["meulsixloblastomaNc"]),
                    XT_Object_To_Stirng(data["relosixomNc"]),
                    XT_Object_To_Stirng(data["maansixNc"])
                )
            case .failure:
                failure?()
            }
        }
    }

    func xt_apply(_ productId: String, success: ((Int, String, Bool) -> Void)?, failure: XTBlock?) {
        LoanFlowCoordinator.shared.loadApplyDecision(productId, success: { decision in
            success?(decision.uploadType, decision.url, decision.isList)
        }, failure: failure)
    }

    func xt_detail(_ productId: String, success: ((String, String) -> Void)?, failure: XTBlock?) {
        LoanFlowCoordinator.shared.loadDetail(productId, success: success, failure: failure)
    }

    func xt_push(_ orderId: String, success: ((String) -> Void)?, failure: XTBlock?) {
        LoanFlowCoordinator.shared.loadPushURL(orderId, success: success, failure: failure)
    }
}

// MARK: - Legacy ObjC shim
typealias XTFirstViewModel = FirstViewModel
