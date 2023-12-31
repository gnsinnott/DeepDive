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
    @State public var stampImage: Image?
    
    @StateObject private var imagePicker = ImagePicker()
    
    var body: some View {
        NavigationStack{
            if stampImage != nil {
                PhotoPickerView(stampImage: stampImage, id: id.uuidString)
            } else {
                PhotoPickerView(id: id.uuidString)
            }
            TextEditor(text: $note)
                .border(.teal)
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
            if let stampImage {
                stampImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            PhotosPicker(stampImage != nil ? "Change dive shop stamp" : "Select dive shop stamp", selection: $stampItem, matching: .images)
        }
        .onChange(of: stampItem) {
            Task {
                if let data = try? await stampItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.stampImage = Image(uiImage: uiImage)
                        saveStampImage(stamp: uiImage, id: id)
                        print("Image Saved")
                        return
                    }
                }
                print("Failed to load image")
            }
        }
    }
}
