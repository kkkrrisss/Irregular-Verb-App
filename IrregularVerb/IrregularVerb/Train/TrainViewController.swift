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
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Score".localized
        
        return label
    }()
    
    private lazy var countVerbLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "1/\(dataSource.count)"
        
        return label
    }()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTappedColorChange), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGray5
        button.setTitle("Skip".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var score = 0
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        return dataSource[count]
    }
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
            checkButton.backgroundColor = .systemGray5
            checkButton.setTitle("Check".localized, for: .normal)
            countVerbLabel.text = "\(count+1)/\(dataSource.count)"
            skipButton.isHidden = false
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        
        setupUI()
        hideKeyboardWhenTappedAround()
        infinitiveLabel.text = dataSource.first?.infinitive
        scoreLabel.text = "Score".localized + ": \(score)"
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
    
    @objc
    private func checkAction() {
        if checkAnswers() && !isAnswersEmpty(){
                score += (checkButton.backgroundColor == .systemRed || checkButton.title(for: .normal) == "Next".localized) ? 0 : 1
                scoreLabel.text = "Score".localized + ": \(score)"
                if currentVerb?.infinitive == dataSource.last?.infinitive {
                    addAlertFinal()
                } else {
                    count += 1
                }
        } else if isAnswersEmpty() {
            addAlertEmptyAnswers()
        } else {
                checkButton.backgroundColor = .systemRed
                checkButton.setTitle("Try Again".localized, for: .normal)
            }
        }
    
    private func checkAnswers() -> Bool {
        
        pastSimpleTextField.text?.lowercased().trimmingCharacters(in: .whitespaces) == currentVerb?.pastSimple &&
        participleTextField.text?.lowercased().trimmingCharacters(in: .whitespaces) == currentVerb?.participle
        
    }
    
    private func isAnswersEmpty() -> Bool {
        pastSimpleTextField.text?.trimmingCharacters(in: .whitespaces) == "" || participleTextField.text?.trimmingCharacters(in: .whitespaces) == ""
    }
    
    private func addAlertFinal() {
        let alert = UIAlertController(title: "Congratulations!🎉".localized, message: "You have completed the verb training with a score of".localized + " \(score)/\(dataSource.count)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func addAlertEmptyAnswers() {
        let alert = UIAlertController(title: "No answer".localized, message: "It seems that the response field is empty. Please enter the answer!".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    @objc
    private func skipAction() {
        checkButton.backgroundColor = .systemGray5
        pastSimpleTextField.text = "\(currentVerb?.pastSimple ?? "")"
        participleTextField.text = "\(currentVerb?.participle ?? "")"
        skipButton.isHidden = true
        checkButton.setTitle("Next".localized, for: .normal)
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
    
    private func setupUI() {
        view.backgroundColor = .white
        
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
