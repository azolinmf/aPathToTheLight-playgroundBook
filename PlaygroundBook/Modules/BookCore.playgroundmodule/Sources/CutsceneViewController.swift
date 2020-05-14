//
//  CutsceneViewController.swift
//  BookCore
//
//  Created by Maria Fernanda Azolin on 13/05/20.
//

import UIKit

//public class CutsceneViewController: UIViewController {
//
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//
//        let view1 = UIImageView(image: UIImage(named: "Page 0"))
//
//        //let view2 = UIView(frame: view.frame)
//        //view2.backgroundColor = .red
//
//        view.addSubview(view1)
//        //view.addSubview(view2)
//
//        view1.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            view1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            view1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            view1.widthAnchor.constraint(equalTo: view.widthAnchor),
//            view1.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//
//
//    }
//
//}

public class CutsceneViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

//        let titleURL = Bundle.main.url(forResource: "Helios Regular", withExtension: "ttf")
//        CTFontManagerRegisterFontsForURL(titleURL! as CFURL, CTFontManagerScope.process, nil)
        //let font1 = UIFont(name: "Helios Regular", size: 50)!
        
        setFirstPage()
        
        
        
        //let view2 = UIView(frame: view.frame)
        //view2.backgroundColor = .red
        
        
        
        
    }
    
    func setFirstPage() {
        let title = UITextView(frame: view.frame)
        title.font = UIFont(name: "Helios Regular", size: 50)
        
        view.addSubview(title)
    
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        let view1 = UIView(frame: view.frame)
        view1.backgroundColor = .black
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view1.widthAnchor.constraint(equalTo: view.widthAnchor),
            view1.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }

    
}
