//
//  SelectVerbsViewController.swift
//  IrregularVerb
//
//  Created by Кристина Олейник on 30.07.2025.
//

import UIKit
import SnapKit

final class SelectVerbsViewController: UITableViewController {
    
    //MARK: - Properties
    private var dataSource = IrregularVerbs()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select verbs".localized
        view.backgroundColor = .white
        //так как ячейку писали кодом, то не через nib, а через cellClass
        tableView.register(SelectVerbTableViewCell.self, forCellReuseIdentifier: "SelectVerbTableViewCell")
        
        dataSource.configureVerbs()
    }
    
    //MARK: - Private methods
    
    private func isSelected(verb: Verb) -> Bool {
        dataSource.selectedVerbs.contains(where: { $0.infinitive == verb.infinitive })
    }
}

//MARK: - UITableViewDataSource

extension SelectVerbsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.verbs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectVerbTableViewCell", for: indexPath) as? SelectVerbTableViewCell else { return UITableViewCell() }
        
        let verb = dataSource.verbs[indexPath.row]
        cell.configure(with: dataSource.verbs[indexPath.row], isSelected: isSelected(verb: verb))
        
        return cell
    }
}


//MARK: - UITableViewDelegate

extension SelectVerbsViewController {
    
    //какую ячейку пользователь нажал
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        let verb = dataSource.verbs[indexPath.row]
        
        if isSelected(verb: verb) {
            dataSource.selectedVerbs.removeAll(where: { $0.infinitive == verb.infinitive })
        } else {
            dataSource.selectedVerbs.append(verb)
        }
        //обновление ячейки
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
}
