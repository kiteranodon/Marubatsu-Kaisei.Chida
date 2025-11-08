//
//  ContentView.swift
//  Marubatsu
//
//  Created by 千田海生 on 2025/11/08.
//

import SwiftUI

struct Quiz: Identifiable, Codable {
    var id = UUID()         //設問を区別するID
    var question: String    //問題文
    var answer: Bool        //回答
}


struct ContentView: View {
    
    // 問題
    let quizExamples: [Quiz] = [
        Quiz(question: "iPhoneアプリを開発する統合環境はZcodeである",answer: false),
        Quiz(question: "Xcode画面の右側にはユーティリティーズがある", answer:true),
        Quiz(question: "Textは文字列を表示する際に利用する", answer: true)
    ]
    
    @State var currentQuestionNum: Int = 0 //今、何問目の数字
    @State var showingAlert = false //アラートの表示 非表示を管理
    @State var alertTitle = "" // 正解か不正解の文字を入れる用の変数
    
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Text(showQuestion()) //問題文を表示
                    .padding() //上下左右余白
                    .frame(width: geometry.size.width * 0.85, alignment: .leading) //横幅を親ビューの0.85倍に, 左寄せに
                    .font(.system(size: 25)) //フォントサイズを25に
                    .fontDesign(.rounded) //丸みのあるフォントに
                    .background(.yellow) //背景を黄色に
                
                
                Spacer() // 余白
                
                HStack{
                    //Oボタン
                    Button {
                        checkAnswer(yourAnswer: true) //ボタンが押されたときの動作
                    } label: {
                        Text("O") //ボタンの見た目
                    }
                    .frame(width: geometry.size.width * 0.4,
                           height: geometry.size.width * 0.4) // 横幅と高さを親ビューの0.4倍を指定
                    .font(.system(size: 100, weight: .bold)) // フォントサイズ: 100 ,太字
                    .foregroundStyle(.white) // 文字の色: 白
                    .background(.red) // 背景色: 赤
                    
                    //Xボタン
                    Button {
                        checkAnswer(yourAnswer: false) //ボタンが押されたときの動作
                    } label: {
                        Text("X") //ボタンの見た目
                    }
                    .frame(width: geometry.size.width * 0.4,
                           height: geometry.size.width * 0.4) // 横幅と高さを親ビューの0.4倍を指定
                    .font(.system(size: 100, weight: .bold)) // フォントサイズ: 100 ,太字
                    .foregroundStyle(.white) // 文字の色: 白
                    .background(.blue) // 背景色: 青
                    
                }
            }
            .padding()
            // ズレを直すのに親ビューのサイズをVStackに適用
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
            
            // 回答時のアラート
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {/* 今回は処理なし */}
            }
        }
    }
    
    // 問題を表示する関数
    func showQuestion() -> String {
        // 配列から〇〇問目の問題文を取り出して代入
        let question = quizExamples[currentQuestionNum].question
        return question
    }
    
    //回答をチェックする関数、正解なら次の問題を表示
    func checkAnswer(yourAnswer: Bool){
        let quiz = quizExamples[currentQuestionNum] //表示されているクイズを取り出す
        let ans = quiz.answer // クイズから解答を取り出す
        if yourAnswer == ans { //正解のとき
            alertTitle = "正解"
            
            //現在の問題番号が問題数(quizExample.count)を超えないように場合分け
            if currentQuestionNum + 1 < quizExamples.count {
                //currentQuestionNumに1を追加して次の問題に進む
                currentQuestionNum += 1
                //currentQuestionNum = currentQuestionNum + 1
            } else {
                //超えるときは0に戻す
                currentQuestionNum = 0
            }
        }else{
            // 不正解のとき
            alertTitle = "不正解"
        }
        showingAlert = true // アラートタイトルを表示させる
            
    }
    
}//ContentViewがここまで

#Preview {
    ContentView()
}
