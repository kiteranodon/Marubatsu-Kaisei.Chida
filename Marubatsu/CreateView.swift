//
//  CreateView.swift
//  Marubatsu
//
//  Created by 千田海生 on 2025/11/08.
//

import SwiftUI

struct CreateView: View {
    
    
    @Binding var quizzesArray: [Quiz] //回答画面で読み込んだ問題を一時的にべつの配列へ
    @State private var questionText = "" //テキストフィールドの文字を受け取る
    @State private var selectedAnswer = "O" //ピッカーで選ばれた解答を受け取る
    let answers = ["O", "X"]
    
    var body: some View {
        VStack {
            Text("問題文と解答を入力して、追加ボタンを押してください")
                .foregroundStyle(.gray)
                .padding()
            
            TextField(text: $questionText){
                Text("問題文を入力してください")
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            //解答を選択するピッカー
            Picker("解答", selection: $selectedAnswer){
                ForEach(answers, id: \.self) { answer in
                    Text(answer)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 300)
            .padding()
            
            //追加ボタン
            Button("追加") {
                addQuiz(question: questionText, answer: selectedAnswer)
            }
            .padding()
            
            // 削除ボタン
            Button {
                quizzesArray.removeAll() // 配列を空に
                UserDefaults.standard.removeObject(forKey: "quiz") // 保存されているものを削除
            } label: {
                Text("全削除")
            }
            .foregroundStyle(.red)
            .padding()
        }
    }
    
    //問題追加・保存の関数
    func addQuiz(question: String, answer: String){
        //問題が入力されているかチェック
        if question.isEmpty{ //未入力のとき 「""」←これも未入力扱い
            print("問題文が入力されていません")
            return
        }
        
        //問題文があったときは以下に処理が続く
        
        //保存するためのtrue/falseを入れておく変数
        var savinganswer = true
        
        // "O"か"X"かでtrue/falseを切り替える
        switch answer{
        case "O":
            savinganswer = true
        case "X":
            savinganswer = false
        default:
            print("適切な答えが入っていません")
            break
        }
        //これから保存する問題をインスタンス化
        let newQuiz = Quiz(question: question, answer: savinganswer)
        
        var array = quizzesArray //一時的に変数に入れておく
        array.append(newQuiz) //作った問題を配列に追加
        let storekey = "quiz" //UserDefaultに保存されるためのキー
        
        
        // エンコードできたら保存
        if let encodedQuizzez = try? JSONEncoder().encode(array){
            UserDefaults.standard.setValue(encodedQuizzez, forKey: storekey)//保存処理
            questionText = "" //テキストフィールドを空白に戻す
            quizzesArray = array //[既存問題 + 新問題]となった配列に更新
        }
    }
}

#Preview {
    //CreateView()
}
