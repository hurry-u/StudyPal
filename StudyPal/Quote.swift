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
            Quote(text: "You don't have to be perfect to be amazing.", author: "Unknown"),
            Quote(text: "Chase your dreams, but always know the road that will lead you home again.", author: "Unknown"),
            Quote(text: "Doubt kills more dreams than failure ever will.", author: "Suzy Kassem"),
            Quote(text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius"),
            Quote(text: "Dream big and dare to fail.", author: "Norman Vaughan"),
            Quote(text: "If you want to achieve greatness, stop asking for permission.", author: "Anonymous"),
            Quote(text: "The biggest risk is not taking any risk. In a world that's changing quickly, the only strategy that is guaranteed to fail is not taking risks.", author: "Mark Zuckerberg"),
            Quote(text: "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.", author: "Albert Schweitzer"),
            Quote(text: "Challenges are what make life interesting and overcoming them is what makes life meaningful.", author: "Joshua J. Marine"),
            Quote(text: "Great things never come from comfort zones.", author: "Roy T. Bennett"),
            Quote(text: "Believe in yourself, take action, and never give up.", author: "Ryan Reynolds"),
            Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
            Quote(text: "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.", author: "Christian D. Larson"),
            Quote(text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson"),
            Quote(text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
            Quote(text: "The harder you work for something, the greater you'll feel when you achieve it.", author: "Unknown"),
            Quote(text: "The secret of getting ahead is getting started.", author: "Mark Twain"),
            Quote(text: "You don't have to be great to start, but you have to start to be great.", author: "Zig Ziglar"),
            Quote(text: "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work.", author: "Steve Jobs"),
            Quote(text: "Don't be afraid to give up the good to go for the great.", author: "John D. Rockefeller"),
            Quote(text: "The only limit to our realization of tomorrow will be our doubts of today.", author: "Franklin D. Roosevelt"),
            Quote(text: "The best way to predict the future is to create it.", author: "Peter Drucker"),
            Quote(text: "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got this.", author: "Chantal Sutherland"),
            Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
            Quote(text: "Success is not in what you have, but who you are.", author: "Bo Bennett"),
            Quote(text: "The only person you are destined to become is the person you decide to be.", author: "Ralph Waldo Emerson"),
            Quote(text: "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart.", author: "Roy T. Bennett"),
            Quote(text: "You miss 100% of the shots you don't take.", author: "Wayne Gretzky"),
            Quote(text: "The greatest glory in living lies not in never falling, but in rising every time we fall.", author: "Nelson Mandela"),
            Quote(text: "The future depends on what you do today.", author: "Unknown"),
            Quote(text: "The best preparation for tomorrow is doing your best today.", author: "H. Jackson Brown Jr."),
            Quote(text: "Your positive action combined with positive thinking results in success.", author: "Shiv Khera"),
            Quote(text: "Your time is limited, don't waste it living someone else's life.", author: "Steve Jobs"),
            Quote(text: "The will to win, the desire to succeed, the urge to reach your full potential... these are the keys that will unlock the door to personal excellence.", author: "Confucius"),
            Quote(text: "Challenges are what make life interesting and overcoming them is what makes life meaningful.", author: "Joshua J. Marine"),
            Quote(text: "Great things never come from comfort zones.", author: "Roy T. Bennett"),
            Quote(text: "Success usually comes to those who are too busy to be looking for it.", author: "Henry David Thoreau"),
            Quote(text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson"),
            Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
            Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
            Quote(text: "Success is not in what you have, but who you are.", author: "Bo Bennett"),
            Quote(text: "The only person you are destined to become is the person you decide to be.", author: "Ralph Waldo Emerson"),
            Quote(text: "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart.", author: "Roy T. Bennett"),
            Quote(text: "You miss 100% of the shots you don't take.", author: "Wayne Gretzky"),
            Quote(text: "The greatest glory in living lies not in never falling, but in rising every time we fall.", author: "Nelson Mandela"),
            Quote(text: "The future depends on what you do today.", author: "Unknown"),
            Quote(text: "The best preparation for tomorrow is doing your best today.", author: "H. Jackson Brown Jr."),
            Quote(text: "Your positive action combined with positive thinking results in success.", author: "Shiv Khera"),
            Quote(text: "Your time is limited, don't waste it living someone else's life.", author: "Steve Jobs"),
            Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
            Quote(text: "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.", author: "Christian D. Larson"),
            Quote(text: "Don't be afraid to give up the good to go for the great.", author: "John D. Rockefeller"),
            Quote(text: "The best way to predict the future is to create it.", author: "Peter Drucker"),
            Quote(text: "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got this.", author: "Chantal Sutherland"),
            Quote(text: "The will to win, the desire to succeed, the urge to reach your full potential... these are the keys that will unlock the door to personal excellence.", author: "Confucius"),
            Quote(text: "Success usually comes to those who are too busy to be looking for it.", author: "Henry David Thoreau"),
            Quote(text: "The secret to getting ahead is getting started.", author: "Mark Twain"),
            Quote(text: "Education is the most powerful weapon which you can use to change the world.", author: "Nelson Mandela"),
            Quote(text: "The expert in everything was once a beginner.", author: "Helen Hayes"),
            Quote(text: "Study hard in silence, let success be your noise.", author: "Frank Ocean"),
            Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon"),
            Quote(text: "In the end, it's not the years in your life that count. It's the life in your years.", author: "Abraham Lincoln"),
            Quote(text: "Life isn't about finding yourself. It's about creating yourself.", author: "George Bernard Shaw"),
            Quote(text: "The stock market is filled with individuals who know the price of everything, but the value of nothing.", author: "Philip Fisher"),
            Quote(text: "The stock market is a device for transferring money from the impatient to the patient.", author: "Warren Buffett"),
            Quote(text: "The best investment you can make is in yourself.", author: "Warren Buffett"),
            Quote(text: "Opportunities come infrequently. When it rains gold, put out the bucket, not the thimble.", author: "Warren Buffett"),
            Quote(text: "Your body hears everything your mind says.", author: "Naomi Judd"),
            Quote(text: "The greatest wealth is health.", author: "Virgil"),
            Quote(text: "Happiness is not a goal; it is a by-product.", author: "Eleanor Roosevelt"),
            Quote(text: "The first wealth is health.", author: "Ralph Waldo Emerson"),
            Quote(text: "The greatest accomplishment is not in never falling, but in rising again after you fall.", author: "Vince Lombardi"),
            Quote(text: "Success is not the absence of failure; it's the persistence through failure.", author: "Aisha Tyler"),
            Quote(text: "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.", author: "Maya Angelou"),
            Quote(text: "Don't be afraid to give up the good to go for the great.", author: "LeBron James")





        ]
        
       
        
        let randomIndex = Int.random(in: 0..<quotesList.count)
        return quotesList[randomIndex]
    }
}
