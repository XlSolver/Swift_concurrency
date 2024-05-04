//
//  DoTryCatchThrowsBootcamp.swift
//  SwiftConcurrency
//
//  Created by Salvatore Flauto on 04/05/24.
//

import SwiftUI

//do-catch
//try
//throws

class DoTryCatchThrowsBootcampDataManager {
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TEXT!", nil)
        } else {
            return ("ERROR", URLError(.badURL))
        }
    }
    
    //< Gives a string or an error -> not both >
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT!")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
//        if isActive {
//            return "NEW TEXT!"
//        } else {
            throw URLError(.badURL)
//        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "FINAL TEXT!"
        } else {
            throw URLError(.badURL)
        }
    }
}

class DoTryCatchThrowsBootcampViewModel: ObservableObject {
    @Published var text: String = "Starting text."
    let manager = DoTryCatchThrowsBootcampDataManager()
    
    func fetchTitle() {
        /* Returns both a result and an errors
         let returnedValue = manager.getTitle()
         if let newTitle = returnedValue.title {
         self.text = newTitle
         } else if let error = returnedValue.error {
         self.text = error.localizedDescription
         }*/
        
        /* needs a check to understand if it is returning a result or an error
         let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }*/
        
        /* the conditional does not throw an error but returns nil
         let newTitle = try? manager.getTitle3()
        if let newTitle = newTitle {
            self.text = newTitle
        }*/
        
        do {
            //Does not throws error so it is jumped and getTitle4 get executed
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch let error {
            self.text = error.localizedDescription
        }
    }
}

struct DoTryCatchThrowsBootcamp: View {
    
    @StateObject private var viewModels = DoTryCatchThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModels.text)
            .frame(width: 300, height: 300)
            .foregroundStyle(.blue)
            .onTapGesture {
                viewModels.fetchTitle()
            }
        
    }
}

#Preview {
    DoTryCatchThrowsBootcamp()
}
