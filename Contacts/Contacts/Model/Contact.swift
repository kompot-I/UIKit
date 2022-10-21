//
//  Messege.swift
//  Contacts
//
//  Created by Nikita  Zubov on 21.10.2022.
//

import Foundation

protocol ContactProtocol {
    ///имя
    var title: String { get set }
    //номер телефона
    var phone: String { get set }
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}
