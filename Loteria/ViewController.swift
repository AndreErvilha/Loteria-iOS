//
//  ViewController.swift
//  Loteria
//
//  Created by Andre Eduardo Ribeiro Ervilha on 22/03/22.
//

import UIKit
import Foundation

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumber(for: .megasena)
    }
    
    func showNumber(for type: GameType){
        lbGameType.text = type.rawValue
        
        var game: [Int] = []
        switch type{
            case .megasena:
                game = randomList(total: 6, universe: 60)
                balls.last!.alpha = 1
                break
            case .quina:
                game = randomList(total: 5, universe: 80)
                balls.last!.alpha = 0
                break
        }
        
        for (index, game) in game.enumerated(){
            balls[index].setTitle("\(game)", for: .normal)
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
            case 0:
                showNumber(for: .megasena)
            default:
                showNumber(for: .quina)
        }
    }
    
    func randomList(total: Int, universe: Int) -> [Int] {
        var result : [Int] = [];
        
        while result.count < 6 {
            let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
            
            if !result.contains(randomNumber) {
                result.append(randomNumber)
            }
        }
        
        return result.sorted()
    }
     
}

