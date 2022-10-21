//
//  ViewController.swift
//  Contacts
//
//  Created by Nikita  Zubov on 21.10.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "Строка \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
    
    //метод - возвращает общее колво строко в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    //возвращает ячейку, определяющую внешний вид данных, выводимых в конкретной строке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //производим попытку загрузки переиспоользуемой ячейки
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
        
            //получаем экземпляр ячейки
            var newCell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
            //коонфигурируем ячейку
            configure(cell: &newCell, for: indexPath)
            
            return newCell
        }
        print("Используем старую ячейку для строки с индексом \(indexPath.row)")
        configure(cell: &cell, for: indexPath)
        //возвращаем сконфигур экземпляр ячейки
        return cell
    }
}
