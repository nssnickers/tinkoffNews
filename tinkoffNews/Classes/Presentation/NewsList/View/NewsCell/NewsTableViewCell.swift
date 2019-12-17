//
//  NewsTableViewCell.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var viewsCountLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Public Methods
    
    func update(with model: NewsListItem) {
        dateLabel.text = model.getDate()
        viewsCountLabel.text = "👀 \(model.getViewsCount())"
        titleLabel.text = model.getTitle()
    }
}
