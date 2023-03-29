//
//  MenuViewController.swift
//  SlideMenu
//
//  Created by Alex Grazhdan on 29.03.2023.
//

import UIKit

protocol MenuViewControllerDelegate : AnyObject {
    func didSelect(manuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {

    enum MenuOptions: String, CaseIterable{
        case home = "Home"
        case info = "Information"
        case appRation = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRation:
                return "star"
            case .shareApp:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = nil
        return tableView
    }()
    
    weak var delegate : MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDelegate{
    
}

extension MenuViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
        cell.textLabel?.textColor = .white
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(manuItem: item)
    }
    
}
