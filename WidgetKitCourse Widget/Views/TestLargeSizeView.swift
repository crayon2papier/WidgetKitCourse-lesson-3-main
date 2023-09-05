//
//  TestLargeSizeView.swift
//  WidgetKitCourse WidgetExtension
//
//  Created by Salima O. on 18/07/2023.
//

import WidgetKit
import SwiftUI

struct TestLargeSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Text("To-Do List")
                    .foregroundColor(.black)
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Text(Date.now, format: .dateTime)
                    .font(.caption)
                    .italic()
                    .opacity(0.4)
                
                
            }
            .padding(18)
            .clipped()
            
            
            ForEach(entry.todos) { todo in
                Link(destination: URL(string: "myapp://todo/\(todo.id)")!) {
                    HStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .frame(width: 30, height: 30)
                            .overlay {
                                if todo.completed {
                                    Image(systemName: "checkmark")
                                }
                            }
                        
                        Text(todo.title)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical,5)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .opacity(0.3)
                   
                }
                .padding(.horizontal, 9)
                
               
            }
            
            Spacer()
        }
        .background(Color("VertPale"))
        //.opacity(0.3)
    }
}

