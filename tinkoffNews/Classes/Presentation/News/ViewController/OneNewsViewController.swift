//
//  OneNewsViewController.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

class OneNewsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var viewsCountLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: - Public Properties
    
    var newsService: NewsServiceProtocol?
    var increaseAction: (() -> Void)?
    
    // MARK: - Private Properties
    
    private var urlSlug: String?
    private var model: NewsArticle?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        increaseAction?()
        if let urlSlug = urlSlug {
            loadData(with: urlSlug)
        }
    }

    // MARK: - Puplic Methods
    
    func update() {
        guard let model = model else { return }
        
        dateLabel.text = model.getDate()
        viewsCountLabel.text = "\(model.getViewsCount())"
        titleLabel.text = model.getTitle()
        textView.attributedText = model.getText()
    }
    
    func setup(urlSlug: String) {
        self.urlSlug = urlSlug
    }
    
    func showError(with message: String) {
        let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func loadData(with url: String) {
        newsService?.getNews(with: url) { (result) in
            switch result {
            case .success(let model):
                self.model = model
                self.update()
            case .failure(let error):
                self.showError(with: "Невозможно получить данные, попробуйте позже")
            }
        }
    }
}
