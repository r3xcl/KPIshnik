//
//  SettingsViewController.swift
//  KPIshnik
//
//  Created by Matthew on 03.11.2021.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

@available(iOS 13.0, *)

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self ,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Настройки"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure(){
        models.append(Section(title: "Основные", options: [
            SettingsOption(title: "Группа", icon: UIImage(systemName: "person"), iconBackgroundColor: .systemPink){
                self.showChoiceGroup()
            },
            SettingsOption(title: "Язык", icon: UIImage(systemName: "network"), iconBackgroundColor: .link){
                
            }
        ]))
        
        models.append(Section(title: "Дизайн", options: [
            SettingsOption(title: "Тема", icon: UIImage(systemName: "paintbrush"), iconBackgroundColor: .systemGreen){
                
            },
            SettingsOption(title: "Иконка приложения", icon: UIImage(systemName: "face.smiling"), iconBackgroundColor: .systemOrange){
                
            }
        ]))
        
        models.append(Section(title: "Полезные ссылки", options: [
            SettingsOption(title: "Карта КПИ", icon: UIImage(systemName: "mappin"), iconBackgroundColor: .systemBlue){
                
                self.showKPImap()
                
            },
            SettingsOption(title: "Чат КПИ live", icon: UIImage(systemName: "message"), iconBackgroundColor: .systemTeal){
                
            }
        ]))
        
    }
    
    func showKPImap(){
        UIApplication.shared.open(NSURL(string: "https://kpi.ua/map.html")! as URL)
    }
    
    
    
     func showChoiceGroup(){
         let storyBoard: UIStoryboard = UIStoryboard (name: "ChoiceGroup", bundle: nil)
         let choiceGroupViewController = storyBoard.instantiateViewController(withIdentifier: "ChoiceGroupViewController") as! ChoiceGroupViewController
         self.present(choiceGroupViewController, animated: true, completion: nil)
         
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models [section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
       guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath
       ) as? SettingsTableViewCell else {
         return UITableViewCell()
                    
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
}
