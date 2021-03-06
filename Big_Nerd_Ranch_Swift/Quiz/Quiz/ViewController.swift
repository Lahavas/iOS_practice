//
//  ViewController.swift
//  Quiz
//
//  Created by Jaeho on 2017. 9. 16..
//  Copyright © 2017년 yeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentQuestionLabel.text = self.questions[self.currentQuestionIndex]
        
        self.updateOffScreenLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nextQuestionLabel.alpha = 0
    }
    
    // MARK: - Memory Management

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        
        self.currentQuestionIndex += 1
        if self.currentQuestionIndex == self.questions.count {
            self.currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        self.nextQuestionLabel.text = question
        
        self.answerLabel.text = "???"
        
        self.animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        
        let answer: String = answers[currentQuestionIndex]
        self.answerLabel.text = answer
    }
    
    // MARK: - Methods
    
    func animateLabelTransitions() {
        
        self.view.layoutIfNeeded()
        
        let screenWidth = self.view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [ .curveLinear ], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            swap(&self.currentQuestionLabel,
                 &self.nextQuestionLabel)
            
            swap(&self.currentQuestionLabelCenterXConstraint,
                 &self.nextQuestionLabelCenterXConstraint)
            
            self.updateOffScreenLabel()
        })
    }
    
    func updateOffScreenLabel() {
        
        let screenWidth = self.view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
}

