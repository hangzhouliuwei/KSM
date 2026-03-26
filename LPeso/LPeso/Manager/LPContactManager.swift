//
//  LPContactManager.swift
//  LPeso
//
//  Created by Kiven on 2024/11/11.
//

import UIKit
import Contacts
import ContactsUI

class LPContactManager: NSObject, CNContactPickerDelegate {
    
    typealias ContactSelectionHandler = (String?, String?) -> Void
    private var selectionHandler: ContactSelectionHandler?
    
    static let shared = LPContactManager()
    
    private override init() { }
    
    func showContactPicker(from viewController: UIViewController, completion: @escaping ContactSelectionHandler) {
        self.selectionHandler = completion
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        viewController.present(contactPicker, animated: true, completion: nil)
    }
    
    // MARK: - CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = CNContactFormatter.string(from: contact, style: .fullName)
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue
        selectionHandler?(fullName, phoneNumber)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        selectionHandler?(nil, nil)
    }
}

