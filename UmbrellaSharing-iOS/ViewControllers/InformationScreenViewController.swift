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

class InformationScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InformationDataModelDelegate {
    
    // TODO: Level 3 Think how to make the height of this talbe dinamic.
    // TODO: Level 3 Extend the width of the label
    // TODO: Level 3 Think how to not show separation lines even before information is loaded
    
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var closeButton: CloseButton!
    
    private let informationViewModel = InformationViewModel()
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestionsAndAnswers()
    }
    
    private func loadQuestionsAndAnswers() {
        informationViewModel.delegate = self
        informationViewModel.load()
    }
    
    private func setupTableView(_ questionsAndAnswers: [FAQEntity]) {
        questionsTable.delegate = self
        questionsTable.dataSource = self
        questionsTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableViewData = questionsAndAnswers.map { cellData(opened: false, title: $0.question, sectionData: [$0.answer]) }
        questionsTable.reloadData()
    }
        
    
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 100
        }
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
    
    @IBAction func closeInformationScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: InformationViewModel Delegate
    
    func didLoadQuestionsAndAnswers(questionsAndAnswers: [FAQEntity]) {
        setupTableView(questionsAndAnswers)
    }
}

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}
