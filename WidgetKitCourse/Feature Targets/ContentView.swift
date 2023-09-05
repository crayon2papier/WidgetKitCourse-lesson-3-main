//
//  ContentView.swift
//  WidgetKitCourse
//
//  Created by Florian Schweizer on 01.12.21.
//

import SwiftUI

struct ContentView: View {
    
    // Test pour tenter de faire app storage
    @State private var text = ""
    @AppStorage ("STRING_KEY") var savedText = ""
  

    
    
    @State var todos: [Todo] = []
    @State var selectedTodo: Todo?
    
    var body: some View {
        NavigationView {
            List(todos) { todo in
                Button {
                    selectedTodo = todo
                } label: {
                    Text("\(todo.title): **\(todo.completed ? "completed" : "open")**")
               
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Liste de choses a faire")
            .task {
                do {
                    todos = try await TodoService.shared.getAllTodos()
                } catch {
                    print(error)
                }
            }
            .sheet(item: $selectedTodo) { todo in
                GroupBox {
                    VStack(alignment: .leading) {
                        Text(todo.title)
                            .font(.headline)
                        
                        Text(todo.completed ? "Completed" : "Open")
                            .font(.subheadline)
                        
                       //  Text("ici mettons notre texte")
                        TextField("Entrez votre note", text: $text)
                            .textFieldStyle(.roundedBorder)
                            .font(.callout)
                            .autocorrectionDisabled(true)
                            .onChange(of: text) { text in
                                self.savedText = text
                            }
                            .onAppear {
                                self.text = savedText
                                print("Loaded : \(savedText)")
                            }
                        
                    }
                } label: {
                    Label("Todo #\(todo.id)", systemImage: "person")
                }
                .padding()
            }
            .onOpenURL { url in
                guard
                    url.scheme == "myapp",
                    url.host == "todo",
                    let id = Int(url.pathComponents[1])
                else {
                    print("issue")
                    return
                }
                
                Task {
                    do {
                        let todo = try await TodoService.shared.getTodo(with: id)
                        DispatchQueue.main.async {
                            selectedTodo = todo
                        }
                    } catch {
                        // handle error in an adequate way
                        print(error)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
