//
//  ConcurrencyCompetition.swift
//  assignment.concurrency
//
//  Created by Salome Lapiashvili on 09.11.23.
//

import UIKit
import BigInt

final class CompetitionManager {
    
    private func generateTwoNumbers() -> (Int, Int) {
        let firstNumber = Int.random(in: 20...50)
        let secondNumber = Int.random(in: 20...50)
        return (firstNumber, secondNumber)
    }
    
    private func factorial(of number: Int) -> BigInt {
        if number < 0 {
            return 0
        }
        
        var result = BigInt(1)
        for i in 1...number {
            result *= BigInt(i)
        }
        return result
    }

    
    private func RostevaniCounts(number1: Int, number2: Int, completion: @escaping () -> Void) {
        DispatchQueue.global().async { [self] in
            _ = self.factorial(of: number1)
            _ = factorial(of: number2)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func AvtandiliCounts(number1: Int, number2: Int, completion: @escaping () -> Void) {
        DispatchQueue.global().async { [self] in
            _ = self.factorial(of: number1)
            _ = factorial(of: number2)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func determineWinner() {
        let (number1, number2) = generateTwoNumbers()
        
        let group = DispatchGroup()
        var winner: String?
        
        group.enter()
        RostevaniCounts(number1: number1, number2: number2) {
            winner = winner ?? "გამარჯვებულია თვით მეომარი უებრო, კვლა მოუბარი წყლიანი არაბეთის ხელმწიფე როსტევანი!"
            group.leave()
        }
        
        group.enter()
        AvtandiliCounts(number1: number1, number2: number2) {
            winner = winner ?? "ორთავე ერთგან მოკლული ყველაი ასჯერ ოცია, მაგრა ავთანდილს ოცითა უფროსი დაუხოცია, გამარჯვებულია ავთანდილი!"
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let theWinner = winner {
                print(theWinner)
            }
        }
    }
}



