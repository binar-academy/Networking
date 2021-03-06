//
//  QuestionViewController.swift
//  Networking
//
//  Created by Muhksin Hilmi on 15/04/2018.
//  Copyright © 2018 Shinkan. All rights reserved.
//

import ReSwift

class QuestionViewController: UIViewController, StoreSubscriber {
    
    var questionList: QuestionTableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self){
            $0.select({$0.questionState})
        }
        store.dispatch(fetchQuestion)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionList = QuestionTableView(frame: .zero)
        questionList?.registerCellClass(QuestionTableViewCell.self)
        guard let list = questionList else {
            return
        }
        view.addSubview(list)
        list.constraintEntireSuperview(toView: view, value: 0)
        
    }
    
    func newState(state: QuestionState) {
       questionList?.initTableView(model: state.questionModel)
    }
}
