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
    func getTitle() -> String {
        return "NEW TEXT!"
    }
}

class DoTryCatchThrowsBootcampViewModel: ObservableObject {
    @Published var test: String = "Starting text."
    let manager = DoTryCatchThrowsBootcampDataManager()
    
    func fetchTitle() {
        let newTitle = manager.getTitle()
        self.test = newTitle
    }
}

struct DoTryCatchThrowsBootcamp: View {
    
    @StateObject private var viewModels = DoTryCatchThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModels.test)
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
