//
//  ViewController.swift
//  ThemeGod
//
//  Created by Max Nelson on 11/28/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit

class Logic {
    static func randomize(_ arr:[String], limit: Int) -> [String] {
        var r:[String] = []
        var usedIndexes:[Int] = []
        var remaining = limit
        while remaining != 0 {
            var strPlaced:Bool = false
            while !strPlaced {
                let randIndex = Int(arc4random_uniform(UInt32(arr.count)))
                if !usedIndexes.contains(randIndex) {
                    let str = arr[randIndex]
                    usedIndexes.append(randIndex)
                    r.append(str)
                    strPlaced = true
                }
            }
            remaining -= 1
        }
        return r
    }
}

class ViewController: UIViewController {
    
    var stack:UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var tagsView:UITextView = {
        let t = UITextView()
        t.layer.cornerRadius = 12
        t.backgroundColor = .darkGray
        t.textColor = .white
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 15)
        return t
    }()
    
    var newTagsView:UITextView = {
        let t = UITextView()
        t.layer.cornerRadius = 12
        t.backgroundColor = .darkGray
        t.textColor = .white
        t.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 15)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    var shuffleButton:UIButton = {
        let b = UIButton()
        b.setTitle("shuffle them tags boi", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        b.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        b.titleLabel?.textColor = .white
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()

    var label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Tag Shuffler 1.0 \nson"
        label.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 40)
        return label
    }()
    
    var tags = ["#code", "#coder", "#swiftlang", "#ios", "#iosdeveloper", "#developer", "#programmer", "#programming", "#webdeveloper", "#siliconslopes", "#siliconvalley", "#process", "#habit", "#android", "#java", "#csharp", "#django", "#python #javascript", "#css", "#html", "#web", "#software", "#startup", "#wwdc", "#apple", "#clean", "#minimalistic", "#minimal", "#simple", "#simplicity", "#airpods", "#ikea", "#modern", "#teamapple", "#photography", "#mobilemag", "#visualsoflife", "#utah", "#saltlakecity", "#newyorkcity", "#sanfransisco", "#moodygrams", "#fatalframes", "#worldcode", "#sony", "#bootcamp", "#frontend", "#bootstrap", "#sass", "#inspiration", "#design", "#webdesign", "#workspace", "#digital", "#setup", "#inspiration", "#sublime", "#work", "#hustle", "#grind", "#html5", "#isetups", "#computerscience", "#computer", "#macbookpro", "#mac", "#macbookair", "#website", "#designer", "#illustrator", "#mkbhd", "#freelance", "#quotes", "#motivation", "#codegoals"
    ]
    
    //        var tags0 = ["hi","max"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tagsView.text = tagsToText(tags)
        ui()
    }
    
    func ui() {
        
        view.backgroundColor = UIColor.white
        view.addSubview(stack)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(tagsView)
        stack.addArrangedSubview(newTagsView)
        stack.addArrangedSubview(shuffleButton)
 
        shuffleButton.addTarget(self, action: #selector(self.shuffle), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.2),
            tagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.35),
            newTagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.35),
            shuffleButton.heightAnchor.constraint(equalToConstant: 60),

            ])
        
        NSLayoutConstraint.activate(stack.getConstraintsTo(view: view, withInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)))
    }
    
    @objc func shuffle() {
        //you can't include more than 5 @ mentions in a single comment.
        //You can't include more than 30 hashtags in a single comment.             <------------ THIS fam.
        //You can't post the same comment multiple times (including emoji)
        tags = textToTags(tagsView.text)
        let shuffled = Logic.randomize(tags, limit: 30)
        newTagsView.text = tagsToText(shuffled)
    }
    
    func textToTags(_ text:String) -> [String] {
        return text.components(separatedBy: " ")
    }
    
    func tagsToText(_ arr:[String]) -> String {
        var newString:String = ""
        for element in arr {
            newString += element + " "
        }
        return newString
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

