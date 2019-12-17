//
//  NewsListViewController.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    let newsCellNibName = "NewsTableViewCell"
    let newsCellReuseIdentifier = "NewsTableViewCell"
    let refreshControlColor = UIColor(named: "main_color")
    let startLoadingItemCount = 10

    // MARK: - IBOutlets

    @IBOutlet private weak var newsTableView: UITableView!
    
    // MARK: - Public Properties
    
    var controller: NewsListOutput?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.sectionHeaderHeight = 56
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.register(UINib(nibName: newsCellNibName, bundle: nil),
                               forCellReuseIdentifier: newsCellReuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = refreshControlColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        newsTableView.refreshControl = refreshControl
        
        controller?.obtainData()
    }
    
    // MARK: - Private Methods
    
    @objc
    private func refreshData() {
        controller?.obtainData()
    }
    
}

extension NewsListViewController: NewsListInput {
    
    func showError(with message: String) {
        let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
        
    func stopRefresh() {
        newsTableView.refreshControl?.endRefreshing()
    }
    
    func reload() {
        newsTableView.reloadData()
    }
    
    func reloadRow(at indexPath: IndexPath) {
        newsTableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func showView(_ view: UIViewController) {
        present(view, animated: true)
    }
}

extension NewsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.obtainItemsCount() ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = controller?.obtainItemModelFor(indexPath) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellReuseIdentifier) as! NewsTableViewCell
        cell.update(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 56))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 26))
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "НОВОСТИ"
        
        blurView.frame = headerView.bounds
        headerView.addSubview(blurView)
        headerView.addSubview(label)
        
        return headerView
    }
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.didSelectItemAt(indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
        guard let itemsCount = controller?.obtainItemsCount() else { return }
        
        if indexPath.item == itemsCount - startLoadingItemCount {
            controller?.obtainMoreData()
        }
    }
}
