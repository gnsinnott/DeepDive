//
//  DiveNotesEntryView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/19/23.
//

import SwiftUI

struct DiveNotesEntryView: View {
    var placeHolder = "Write a note about your dive."
    @Binding public var note: String
    var body: some View {
       
        NavigationStack{
            TextEditor(text: $note)
                .foregroundColor(self.note == placeHolder ? .gray : .primary)
                .onTapGesture {
                    if self.note == placeHolder {
                        self.note = ""
                    }
                }
                .padding(.horizontal)
            .navigationTitle("Dive Note")
        }
        .onAppear(){
            if (note == "") {
                note = placeHolder
            }
        }
    }
}

//#Preview {
//    DiveNotesEntryView(note: "")
//}
