//
//  Quote.swift
//  StudyPal
//
//  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
//

struct Quote {
    let text: String
    let author: String
    
    static func getRandomQuote() -> Quote {
        let quotesList = [
            Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
            Quote(text: "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.", author: "Christian D. Larson"),
            Quote(text: "The only way to do great work is to love what you do. If you haven’t found it yet, keep looking. Don’t settle.", author: "Steve Jobs")
            // Add more quotes here
        ]
        
        let randomIndex = Int.random(in: 0..<quotesList.count)
        return quotesList[randomIndex]
    }
}
