//
//  PKCertificationContactItemHelper.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//

import ContactsUI

class PkAddressManager: NSObject, CNContactPickerDelegate {

    var chooseBack: ((_ contactInfo: [String: String]) -> Void)?

    func openAddressPage() {
        let addressPage = CNContactPickerViewController()
        addressPage.delegate = self
        addressPage.modalPresentationStyle = .fullScreen
        addressPage.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(addressPage, animated: true, completion: nil)
        }
    }
}

extension PkAddressManager {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let telNumber = "\(contactProperty.contact.familyName)\(contactProperty.contact.givenName)"
        let telToName = (contactProperty.value as? CNPhoneNumber)?.stringValue ?? ""
        chooseBack?(["telNumber": telNumber, "telToName": telToName])
    }
}
