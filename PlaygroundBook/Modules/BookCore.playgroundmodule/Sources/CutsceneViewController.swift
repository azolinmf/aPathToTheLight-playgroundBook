//
//  CutsceneViewController.swift
//  BookCore
//
//  Created by Maria Fernanda Azolin on 13/05/20.
//

import UIKit
import SpriteKit

public class CutsceneViewController: UIViewController {
    
    var page = 0
    
    let intro = UIImageView(image: UIImage(named: "introBackground"))
    let titleText = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    let firstPageView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    let firstPageSKView = SKView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    let firstPageScene = SKScene(fileNamed: "FirstPage")
    let firstPageNumbers = UIImageView(image: UIImage(named: "numbers1"))
    let firstPlanetSKView = SKView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let firstPlanetScene = SKScene(fileNamed: "PlanetScene")
    let planetNode = SKSpriteNode(imageNamed: "planet")
    
    let tapToContinueView = SKView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    let tapToContinueScene = SKScene(fileNamed: "TapToContinue")
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)

        createTapToContinueScene()
        
        createIntro()
        
        
    }
    
    func createFirstPage() {
        
        firstPageView.backgroundColor = .black
        
        createFirstPageTexts()
        
        createFirstPageNumbers()
        
        createFirstPagePlanet()

        firstPageView.addSubview(tapToContinueView)
        NSLayoutConstraint.activate([
            tapToContinueView.bottomAnchor.constraint(equalTo: firstPageView.bottomAnchor),
            tapToContinueView.centerYAnchor.constraint(equalTo: firstPageView.centerYAnchor),
            tapToContinueView.widthAnchor.constraint(equalTo: firstPageView.widthAnchor, multiplier: 0.2),
            tapToContinueView.heightAnchor.constraint(equalTo: firstPageView.heightAnchor, multiplier: 0.1),
            tapToContinueView.trailingAnchor.constraint(equalTo: firstPageView.trailingAnchor)
        ])
        
        
        view.addSubview(firstPageView)
        firstPageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstPageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstPageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstPageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            firstPageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func createFirstPagePlanet() {
        
        planetNode.position = CGPoint(x: 0, y: 0)
        planetNode.size = CGSize(width: 70, height: 57)
        
        let circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: 10), cornerRadius: 50)
        let followCircle = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, speed: 10.0)
        let repeatCircle = SKAction.repeatForever(followCircle)
        planetNode.run(repeatCircle)
        
        firstPlanetScene!.addChild(planetNode)
        firstPlanetScene?.backgroundColor = .clear
        
        firstPlanetScene?.size = firstPlanetSKView.frame.size
        firstPlanetScene!.scaleMode = .aspectFit
        firstPlanetSKView.presentScene(firstPlanetScene)
        firstPlanetSKView.backgroundColor = .clear
        
        firstPageView.addSubview(firstPlanetSKView)
        firstPlanetSKView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstPlanetSKView.widthAnchor.constraint(equalTo: firstPageView.widthAnchor, multiplier: 0.25),
            firstPlanetSKView.heightAnchor.constraint(equalTo: firstPageView.heightAnchor, multiplier: 0.25),
            firstPlanetSKView.trailingAnchor.constraint(equalTo: firstPageView.trailingAnchor, constant: 10),
            firstPlanetSKView.topAnchor.constraint(equalTo: firstPageView.topAnchor, constant: 80)
        ])
        

    }
    
    func createFirstPageNumbers() {
        
        firstPageView.addSubview(firstPageNumbers)
        firstPageNumbers.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstPageNumbers.centerXAnchor.constraint(equalTo: firstPageView.centerXAnchor),
            firstPageNumbers.bottomAnchor.constraint(equalTo: firstPageView.bottomAnchor, constant: -15),
            firstPageNumbers.widthAnchor.constraint(equalTo: firstPageView.widthAnchor, multiplier: 0.1),
            
        ])
        
    }
    
    func createFirstPageTexts() {
        
        firstPageScene!.scaleMode = .aspectFit
        firstPageScene?.backgroundColor = .clear
        firstPageScene?.alpha = 0.0
        let appear = SKAction.fadeAlpha(to: 1.0, duration: 3.0)
        firstPageScene?.run(appear)
        
        
        firstPageSKView.presentScene(firstPageScene)
        firstPageSKView.backgroundColor = .clear
        
        firstPageView.addSubview(firstPageSKView)
        firstPageSKView.translatesAutoresizingMaskIntoConstraints = false
        
        firstPageSKView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstPageSKView.centerXAnchor.constraint(equalTo: firstPageView.centerXAnchor),
            firstPageSKView.widthAnchor.constraint(equalTo: firstPageView.widthAnchor),
            firstPageSKView.heightAnchor.constraint(equalTo: firstPageView.heightAnchor, multiplier: 0.7),
            firstPageSKView.topAnchor.constraint(equalTo: firstPageView.topAnchor, constant: 100)
        ])
    }
    
    func createTapToContinueScene() {
        
        tapToContinueScene!.scaleMode = .aspectFill
        tapToContinueScene?.backgroundColor = .clear
        let fadeIn = SKAction.fadeIn(withDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 1.5)
        let sequence = SKAction.sequence([fadeIn, fadeOut])
        let repeatSequence = SKAction.repeatForever(sequence)
        tapToContinueScene?.run(repeatSequence)
        
        tapToContinueView.presentScene(tapToContinueScene)
        tapToContinueView.backgroundColor = .clear
                
        tapToContinueView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func createIntro() {
        
        createTitleToIntro()
        
        createSubTitleToIntro()
    
        intro.addSubview(tapToContinueView)
        
        NSLayoutConstraint.activate([
            tapToContinueView.bottomAnchor.constraint(equalTo: intro.bottomAnchor),
            tapToContinueView.centerYAnchor.constraint(equalTo: intro.centerYAnchor),
            tapToContinueView.widthAnchor.constraint(equalTo: intro.widthAnchor, multiplier: 0.2),
            tapToContinueView.heightAnchor.constraint(equalTo: intro.heightAnchor, multiplier: 0.1),
            tapToContinueView.trailingAnchor.constraint(equalTo: intro.trailingAnchor)
        ])

        
        view.addSubview(intro)
        intro.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            intro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            intro.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            intro.widthAnchor.constraint(equalTo: view.widthAnchor),
            intro.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        
    }
    
    func createSubTitleToIntro() {
        
        let cfURL2 = Bundle.main.url(forResource: "jd_equinox", withExtension: "ttf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
        let subtitleFont = UIFont(name: "JD Equinox", size:  60.0)
        
        //creates and adds subtitle
        let subtitle = UITextField(frame: intro.frame)
        subtitle.text = "IN OUTER SPACE"
        subtitle.adjustsFontSizeToFitWidth = true
        subtitle.textColor = .white
        subtitle.backgroundColor = .clear
        subtitle.textAlignment = .center
        subtitle.font = subtitleFont
        
        intro.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle.centerXAnchor.constraint(equalTo: intro.centerXAnchor),
            subtitle.centerYAnchor.constraint(equalTo: titleText.centerYAnchor, constant: 100),
            subtitle.widthAnchor.constraint(equalTo: intro.widthAnchor, multiplier: 0.9),
            subtitle.heightAnchor.constraint(equalTo: intro.heightAnchor, multiplier: 0.15)
        ])
        
    }
    
    func createTitleToIntro() {
        //imports custom fonts
        let cfURL = Bundle.main.url(forResource: "Helios Regular", withExtension: "ttf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let titleFont = UIFont(name: "Helios Pro", size:  90.0)
        
        //creates and adds title
        titleText.text = "PATH FINDING ALGORITHMS"
        titleText.adjustsFontSizeToFitWidth = true
        titleText.textColor = .white
        titleText.backgroundColor = .clear
        titleText.textAlignment = .center
        titleText.font = titleFont
        
        
        intro.addSubview(titleText)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleText.centerXAnchor.constraint(equalTo: intro.centerXAnchor),
            titleText.centerYAnchor.constraint(equalTo: intro.centerYAnchor),
            titleText.widthAnchor.constraint(equalTo: intro.widthAnchor, multiplier: 0.9),
            titleText.heightAnchor.constraint(equalTo: intro.heightAnchor, multiplier: 0.15)
        ])
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        switch (page) {
        case 0:
            intro.isHidden = true
            page += 1
            createFirstPage()
        case 1:
            //view3.isHidden = true
            page += 1
        default:
            break;
        }
         
        
    }

}


