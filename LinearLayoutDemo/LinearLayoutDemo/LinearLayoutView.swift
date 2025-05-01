//
//  LinearLayoutView.swift
//  LinearLayoutDemo
//
//  Created by song on 2025/5/1.
//

import UIKit

class LinearLayoutView: UIView {
    convenience init(tableView: UITableView, edgeInsets: UIEdgeInsets = .zero) {
        self.init()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom)
        ])
        
        self.tableView = tableView
        self.tableView!.tableHeaderView = self
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.tableView!.widthAnchor),
        ])
    }
    
    private weak var tableView: UITableView?
    
    private var workItem: DispatchWorkItem?
    
    private func performDelayedAction(after delay: TimeInterval = 0.09, action: @escaping () -> Void) {
        workItem?.cancel()
        let newWorkItem = DispatchWorkItem { action() }
        workItem = newWorkItem
        DispatchQueue.main.asyncAfter(deadline:.now() + delay, execute: newWorkItem)
    }
    
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        performDelayedAction() { [unowned self] in
            self.refreshUI()
        }
    }
    
    @MainActor
    private func refreshUI() {
        tableView?.tableHeaderView = self
    }
    
    lazy var stackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

