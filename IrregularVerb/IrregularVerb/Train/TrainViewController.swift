//
//  TrainViewController.swift
//  IrregularVerb
//
//  Created by Кристина Олейник on 30.07.2025.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    //MARK: - GUI Properties
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private let contentView: UIView = UIView()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Score".localized
        
        return label
    }()
    
    private let countVerbLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
    }()
    
    private let infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        
        return label
    }()
    
    private let participleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private let pastSimpleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        
        return field
    }()
    
    private let participleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        
        return field
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGray5
        button.setTitle("Skip".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
       
        return button
    }()
    
    //MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var score = 0
    private var isScoreCredited: Bool = true
    
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        return dataSource[count]
    }
   
    private var isAnswersEmpty: Bool {
        pastSimpleTextField.text == "" || participleTextField.text == ""
    }
    
    private var checkAnswers: Bool {
        pastSimpleTextField.text == currentVerb?.pastSimple &&
        participleTextField.text == currentVerb?.participle
    }
    
    private var count = 0 {
        didSet {
            changedInfinitive()
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    //MARK: - Private Methods
    
    //MARK: Action
    @objc
    private func checkAction() {
        textFieldNormalized()
        
        if checkAnswers{
            score += isScoreCredited ? 1 : 0
            scoreLabel.text = "Score".localized + ": \(score)"
            
            if currentVerb?.infinitive == dataSource.last?.infinitive {
                showAlert(title: "Congratulations!🎉".localized,
                          message: "You have completed the verb training with a score of".localized + " \(score)/\(dataSource.count)",
                          buttonTitle: "OK".localized) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                count += 1
            }

        } else if isAnswersEmpty {
            showAlert(title: "No answer".localized,
                      message: "It seems that the response field is empty. Please enter the answer!".localized,
                      buttonTitle: "OK".localized)
            
        } else {
            wrongAnswer()
        }
    }
    
    @objc
    private func skipAction() {
        checkButton.backgroundColor = .systemGray5
        pastSimpleTextField.text = "\(currentVerb?.pastSimple ?? "")"
        participleTextField.text = "\(currentVerb?.participle ?? "")"
        skipButton.isHidden = true
        checkButton.setTitle("Next".localized, for: .normal)
        isScoreCredited = false
    }
    
    //MARK: Logic
    private func textFieldNormalized() {
        pastSimpleTextField.text = pastSimpleTextField.text?.trimmingCharacters(in: .whitespaces).lowercased()
        participleTextField.text = participleTextField.text?.trimmingCharacters(in: .whitespaces).lowercased()
    }
    
    private func wrongAnswer() {
        checkButton.backgroundColor = .systemRed
        checkButton.setTitle("Try Again".localized, for: .normal)
        isScoreCredited = false
    }
    
    private func changedInfinitive() {
        infinitiveLabel.text = currentVerb?.infinitive
        pastSimpleTextField.text = ""
        participleTextField.text = ""
        
        checkButton.backgroundColor = .systemGray5
        checkButton.setTitle("Check".localized, for: .normal)
        
        countVerbLabel.text = "\(count+1)/\(dataSource.count)"
        
        skipButton.isHidden = false
        
        isScoreCredited = true
    }
    @objc
    private func buttonTappedColorChange() {
        let originalColor = checkButton.backgroundColor
        
        if originalColor == .systemRed {
            checkButton.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.checkButton.backgroundColor = originalColor
            }
        }
    }
    
    //MARK: Alert
    
    private func showAlert(title: String, message: String, buttonTitle: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            handler?()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: Setup
    
    private func setupLabel() {
        countVerbLabel.text = "1/\(dataSource.count)"
    }
    
    private func setupTextField() {
        pastSimpleTextField.delegate = self
        participleTextField.delegate = self
    }
    
    private func setupCheckButton() {
        checkButton.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(buttonTappedColorChange), for: .touchUpInside)
    }
    
    private func setupSkipButton() {
        skipButton.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        infinitiveLabel.text = dataSource.first?.infinitive
        scoreLabel.text = "Score".localized + ": \(score)"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([countVerbLabel,
                                 infinitiveLabel,
                                 scoreLabel,
                                 pastSimpleLabel,
                                 pastSimpleTextField,
                                 participleLabel,
                                 participleTextField,
                                 checkButton,
                                 skipButton])
        
        setupLabel()
        setupTextField()
        setupCheckButton()
        setupSkipButton()
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        countVerbLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(edgeInsets)
            make.trailing.equalToSuperview().inset(edgeInsets)
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalTo(countVerbLabel.snp.bottom).offset(160)
            make.centerX.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(80)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
            make.height.equalTo(120)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
            make.height.equalTo(40)
        }
    }
}

//MARK: - UITextFieldDelegate

extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.text = textField.text?.trimmingCharacters(in: .whitespaces).lowercased()
//    }
}

//MARK: - Keyboards events
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_ :)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    //отписка от нотификаций
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = frame.height
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = .zero
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
