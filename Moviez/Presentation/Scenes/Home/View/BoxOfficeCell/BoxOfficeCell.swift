//
//  BoxOfficeCell.swift
//  Moviez
//
//  Created by MacBook  on 09.07.21.
//

import UIKit

class BoxOfficeCell: UITableViewCell, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var boxOfficeList: [BoxOffice]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.registerNib(class: BoxOfficeItem.self)
        self.tableView.dataSource = self
        self.tableView.tableHeaderView?.isHidden = true
        self.tableView.tableFooterView?.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(BoxOfficeItem.self, for: indexPath)
        cell.configure(with: boxOfficeList?[indexPath.row])
        return cell
    }
    


}
