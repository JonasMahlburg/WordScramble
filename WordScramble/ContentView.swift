//
//  ContentView.swift
//  WordScramble
//
//  Created by Jonas Mahlburg on 23.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter a word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        // extra validation to come
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame(){
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silksong"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle!")
    }
}

#Preview {
    ContentView()
}
