//
//  InformationScreenViewController.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/07/18.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation
import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class InformationScreenViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var closeButton: CloseButton!
    
    // MARK: Private
    
    private let informationViewModel = InformationViewModel()
    private var tableViewData = [cellData]()
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestionsAndAnswers()
    }
    
    // MARK: Private Methods
    
    private func loadQuestionsAndAnswers() {
        informationViewModel.delegate = self
        self.view.makeToastActivity(.center)
        informationViewModel.load()
    }
    
    private func setupTableView(_ questionsAndAnswers: [FAQEntity]) {
        questionsTable.delegate = self
        questionsTable.dataSource = self
        questionsTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableViewData = questionsAndAnswers.map { cellData(opened: false, title: $0.question, sectionData: [$0.answer]) }
        questionsTable.reloadData()
    }
    
    // MARK: IB Actions
    
    @IBAction func closeInformationScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension InformationScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = questionsTable.dequeueReusableCell(withIdentifier: "questionCell") as? QuestionCell else { return UITableViewCell()}
            let questionText = tableViewData[indexPath.section].title
            cell.setQuestionCell(questionText)
            return cell
        } else {
            guard let cell = questionsTable.dequeueReusableCell(withIdentifier: "answerCell") as? AnswerCell else { return UITableViewCell()}
            let answerText = tableViewData[indexPath.section].sectionData[dataIndex]
            cell.answerLabel.text = answerText
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cell = questionsTable.cellForRow(at: indexPath) as! QuestionCell
            if tableViewData[indexPath.section].opened {
                tableViewData[indexPath.section].opened = false
                tableView.reloadData() {
                    cell.changeTheState()
                }
            } else {
                tableViewData[indexPath.section].opened = true
                tableView.reloadData() {
                    cell.changeTheState()
                }
            }
        }
    }
}

extension InformationScreenViewController: InformationDataModelDelegate {
    func didLoadQuestionsAndAnswers(questionsAndAnswers: [FAQEntity]) {
        self.view.hideToastActivity()
        setupTableView(questionsAndAnswers)
    }
}

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}
