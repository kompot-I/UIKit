//
//  ViewController.swift
//  Contacts
//
//  Created by Nikita  Zubov on 21.10.2022.
//

import UIKit


class ViewController: UIViewController {
    
    //связь с "Contact"
    var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort{ $0.title < $1.title }
        }
    }
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadContacts()
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "Alex Coco", phone: "+79998884356"))
        contacts.append(Contact(title: "Danya M", phone: "+79783434556"))
        contacts.append(Contact(title: "Vanya Bobov", phone: "+79569453434"))
    }
    
    @IBAction func showNewContactAlert() {
        //создание Alert Controller
        let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        
        //добавляем первое текстовое поле в Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
        }
        //добавляем второе текстовое поле в Alert Controller
        alertController.addTextField { textField in
            textField.placeholder = "Номер телефона"
        }
        // создаем кнопки
        // кнопка создания контакта
        let createButton = UIAlertAction(title: "Создать", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else { return }
            
            // создаем новый контакт
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        // кнопка отмены
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        // добавляем кнопки в Alert Controller
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        // отображаем Alert Controller
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    //метод - возвращает общее колво строко в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        //поддержка ios 13 и ниже
        if #available(iOS 14, *) {
            var configuration = cell.defaultContentConfiguration()
            //имя контакта
            configuration.text = contacts[indexPath.row].title
            //номер телефона конттакта
            configuration.secondaryText = contacts[indexPath.row].phone
            cell.contentConfiguration = configuration
        } else {
            cell.textLabel?.text = "\(indexPath.row)"
        }
    }
    
    //возвращает ячейку, определяющую внешний вид данных, выводимых в конкретной строке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
            
        } else {
            //производим попытку загрузки переиспоользуемой ячейки
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
        
            //получаем экземпляр ячейки
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        //конфигурируем ячейку
        configure(cell: &cell, for: indexPath)
        //возвращаем сконфигур экземпляр ячейки
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //определяем доступные действия для строки
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            //удаляем контакт
            self.contacts.remove(at: indexPath.row)
            //заново формируем табличное представление
            tableView.reloadData()
        }
        //формируем экземпляр описывающий доступные действия
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
