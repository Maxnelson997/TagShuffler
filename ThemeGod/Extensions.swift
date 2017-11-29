//
//  Extensions.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}


enum Direction:CGFloat {
    case up = -1
    case down = 1
    case back = 0
}
extension UIView {
    func animateView(direction:Direction, distance:CGFloat, withAnimation:Bool = true) {
        if withAnimation {
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(translationX: 0, y: distance * direction.rawValue)
            }
        } else{
            self.transform = CGAffineTransform(translationX: 0, y: distance * direction.rawValue)
        }
    }
}

enum CustomFont: String {

    case ProximaNovaRegular = "ProximaNova-Regular"
    case ProximaNovaThin = "ProximaNovaT-Thin"
    case ProximaNovaLight = "ProximaNova-Light"
    case ProximaNovaSemibold = "ProximaNova-Semibold"
}

extension UIFont {
    convenience init?(customFont: CustomFont, withSize size: CGFloat) {
        self.init(name: customFont.rawValue, size: size)
    }
}

extension UIView {
    func getConstraintsTo(view: UIView, withInsets:UIEdgeInsets) -> [NSLayoutConstraint] {
        print(withInsets)
        
        return [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: withInsets.left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1*(withInsets.right)),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: withInsets.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1*(withInsets.bottom
                ))
        ]
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIView {
    func addDropShadowToView(){
        self.layer.masksToBounds =  false
        self.layer.shadowColor = UIColor.gray.withAlphaComponent(0.9).cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 5
    }
}

extension UIColor {
    
    open class var appleBlue: UIColor { return UIColor.init(red: 14, green: 122, blue: 254) }
    open class var textbg: UIColor { return UIColor.init(rgb: 0xE4FBFF)}
    open class var darkPurp: UIColor { return UIColor.init(rgb: 0x3023AE)}
    open class var lightPink: UIColor { return UIColor.init(rgb: 0xC86DD7)}
    open class var grayDient: UIColor { return UIColor.init(rgb: 0xCDCDCD )}
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


