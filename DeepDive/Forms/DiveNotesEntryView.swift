//
//  DiveNotesEntryView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/19/23.
//

import SwiftUI
import PhotosUI

struct DiveNotesEntryView: View {
    var placeHolder = "Write a note about your dive."
    var id: UUID
    @Binding public var note: String
    @Binding public var stampImage: Image?
    
    @StateObject private var imagePicker = ImagePicker()
    
    var body: some View {
       
        NavigationStack{
            PhotoPickerView(id: id.uuidString)
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

struct PhotoPickerView: View {
    @State private var stampItem: PhotosPickerItem?
    @State public var stampImage: Image?
    var id: String
    
    var body: some View {
        VStack {
            PhotosPicker("Select dive shop stamp", selection: $stampItem, matching: .images)
            
            if let stampImage {
                stampImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: stampItem) {
            Task {
                if let data = try? await stampItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.stampImage = Image(uiImage: uiImage)
                        saveStampImage(stamp: uiImage, id: id)
                        return
                    }
                }
                print("Failed")
            }
        }
    }
}


//#Preview {
//    DiveNotesEntryView(note: "")
//}