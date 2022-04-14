//
//  ViewController.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 10.04.2022.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 5
    var selectedRow = 0
    
    var repeatValueTypes : KeyValuePairs = [
        "Never" : false,
        "Always" : true
    ]
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let separator: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .secondarySystemBackground
        return uiView
    }()
    
    let titleLabel: UILabel = {
        let label = CustomLabel(withInsets: 10, 10, 20, 10)
        label.text = "Get Groceries"
        label.backgroundColor = .systemBackground
        return label
    }()
    
    lazy var switchReminderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        [self.reminfMeOnADayLabel,
         self.remindMeOnADay].forEach { stackView.addArrangedSubview($0) }
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    lazy var repeatStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        [self.repeatLabel,
         self.repeatButton].forEach { stackView.addArrangedSubview($0) }
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    lazy var switchRemindMeAtALocationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        [self.remindMeAtALocationLabel,
         self.remindMeAtALocation].forEach { stackView.addArrangedSubview($0) }
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    lazy var segmentedControlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        [self.segmentedControlLabel,
         self.mySegmentedControl].forEach { stackView.addArrangedSubview($0) }
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    lazy var notesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        [self.notesLabel,
         self.textField].forEach { stackView.addArrangedSubview($0) }
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    
    let remindMeOnADay = UISwitch()
    let reminfMeOnADayLabel: UILabel = {
        let label = CustomLabel(withInsets: 10, 10, 20, 10)
        label.text = "Remind me on a day"
        return label
    }()
    
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemBackground
        return datePicker
    }()
    
    let repeatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Never >", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        return button
    }()
    
    let repeatLabel: UILabel = {
        let label = CustomLabel(withInsets: 10, 10, 20, 10)
        label.text = "Repeat"
        return label
    }()
    
    let remindMeAtALocation = UISwitch()
    let remindMeAtALocationLabel: UILabel = {
        let label = CustomLabel(withInsets: 10, 10, 20, 10)
        label.text = "Remind me at a location"
        return label
    }()
    
    let repeatPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let segmentedControlLabel: UILabel = {
        let label = CustomLabel(withInsets: 10, 10, 20, 10)
        label.text = "Priority"
        return label
    }()
    let mySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl (items: ["None", "!","!!","!!!"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor(named: "customBlue")?.cgColor
        segmentedControl.selectedSegmentTintColor = UIColor(named: "customBlue")
        return segmentedControl
    }()
    
    
    let notesLabel: UILabel = {
        let label = CustomLabel(withInsets: 10, 10, 20, 10)
        label.text = "Notes"
        return label
    }()
    let textField = UITextField()
    
    let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTapped))
    let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelTapped))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        addNavigationBar()
        configureScrollView()
        setupViews()
        
        scrollView.delegate = self
        repeatButton.addTarget(self, action: #selector(popUpPicker), for: .touchUpInside)
        mySegmentedControl.addTarget(self, action: #selector(changeAndRepeat(sender:)), for: .valueChanged)
    }
    
    private func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width)
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    func setupViews(){
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView.snp.top).offset(40)
            $0.width.equalTo(contentView.snp.width)
        }
        
        contentView.addSubview(switchReminderStackView)
        switchReminderStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.width.equalTo(contentView.snp.width)
        }
        switchReminderStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        switchReminderStackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(switchReminderStackView.snp.bottom)
            $0.width.equalTo(contentView.snp.width)
            
        }
        
        contentView.addSubview(repeatStackView)
        repeatStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(datePicker.snp.bottom)
            $0.width.equalTo(contentView.snp.width)
            
        }
        repeatStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        repeatStackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(switchRemindMeAtALocationStackView)
        switchRemindMeAtALocationStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(repeatStackView.snp.bottom).offset(40)
            $0.width.equalTo(contentView.snp.width)
            
        }
        switchRemindMeAtALocationStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        switchRemindMeAtALocationStackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(segmentedControlStackView)
        segmentedControlStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(switchRemindMeAtALocationStackView.snp.bottom).offset(40)
            $0.width.equalTo(contentView.snp.width)
        }
        segmentedControlStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        segmentedControlStackView.isLayoutMarginsRelativeArrangement = true
        
        contentView.addSubview(notesStackView)
        contentView.addSubview(separator)
        separator.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segmentedControlStackView.snp.bottom)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            $0.height.equalTo(1)
        }
        notesStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segmentedControlStackView.snp.bottom)
            $0.width.equalTo(contentView.snp.width)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        segmentedControlStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        segmentedControlStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func openProfileVC(){
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func addNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTapped))
        self.navigationController?.navigationBar.topItem?.title = "Create Reminder"
        self.navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .never
    }
    
    @objc private func doneTapped(){
        openProfileVC()
    }
    
    @objc func changeAndRepeat(sender: UISegmentedControl) {
        if( sender.selectedSegmentIndex == 1){
            print("!")
        }else if(sender.selectedSegmentIndex == 2){
            print("!!")
        }else if(sender.selectedSegmentIndex == 3){
            print("!!!")
        }
    }
    
    @objc private func cancelTapped(){
        
    }
    
    @objc private func popUpPicker(){
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(screenHeight)
            $0.width.equalTo(screenWidth)
        }
        
        let alert = UIAlertController(title: "Repeat", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = repeatButton
        alert.popoverPresentationController?.sourceRect = repeatButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.repeatValueTypes)[self.selectedRow]
            let name = selected.key
            self.repeatButton.setTitle("\(name) >", for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return repeatValueTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Array(repeatValueTypes)[row].key
        label.sizeToFit()
        return label
    }
}
