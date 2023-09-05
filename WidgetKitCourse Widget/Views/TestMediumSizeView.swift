//
//  TestMediumSizeView.swift
//  WidgetKitCourse WidgetExtension
//
//  Created by Salima O. on 18/07/2023.
//

import WidgetKit
import SwiftUI

struct TestMediumSizeView: View {
    var entry: SimpleEntry
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                
                VStack (spacing: 10){
                    if let todo = entry.todos.first {
                        VStack(alignment: .leading) {
                            Text(todo.completed ? "Validée" : "En cours")
                                .font(.title2)
                                .bold()
                            
                            Text(todo.title)
                                .font(.subheadline)
                        }
                    }
                }
             
                Spacer()
                
                HStack {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .font(.footnote)
                        .opacity(0.5)
                    
                    Text("Cliquez ici pour continuer")
                        .font(.footnote)
                        .opacity(0.5)
                }
               // .padding()
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .opacity(0.1)
            }
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "highlighter")
                Text("Voir mes notes")
                    .font(.caption)
                Spacer()
                Image(systemName: "list.bullet")
                
            }
        }
        .widgetURL(URL(string: "myapp://todo/\(entry.todos.first?.id ?? 0)"))
    }
}
