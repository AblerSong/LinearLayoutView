//
//  ViewController.swift
//  LinearLayoutDemo
//
//  Created by song on 2025/5/1.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        testUI()
    }
    
    lazy var tableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var stackView = {
        LinearLayoutView(tableView: tableView)
    }()
    
    
    
    
    func testUI() {
        for i in 0...100 {
            let label = UILabel()
            label.text = "\(i)"
            label.backgroundColor = .random
            stackView.addArrangedSubview(label)
            if i == 10 {
                let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
                stackView.addArrangedSubview(v)
                NSLayoutConstraint.activate([
                    v.heightAnchor.constraint(equalToConstant: 100)
                ])
            }
        }
        DispatchQueue.main.asyncAfter(deadline:.now() + 2) {
            let v = UIButton(type: .system)
            v.backgroundColor = .random
            self.stackView.addArrangedSubview(v)
            NSLayoutConstraint.activate([
                v.heightAnchor.constraint(equalToConstant: 500)
            ])
        }
    }
    
}

extension UIColor {
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return UIColor(red: red, green: green, blue: blue)
    }
    
    convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}
