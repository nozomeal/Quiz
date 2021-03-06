//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //出題数
    var questionNumber:Int = 5
    
    //現在の問題数
    var sum:Int = 0
    
    //正解数
    var correctAnswer:Int = 0
    
    //乱数
    var random:Int = 0
    
    //クイズを格納する配列
    var quizArray = [NSMutableArray]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons: Array<UIButton>!
    
    //正誤の表示
    @IBOutlet var seikai: UIImageView!
    
    
    
    //@IBOutlet var americanshort1: UIImageView!
    //@IBOutlet var americanshort2: UIImageView!
    //@IBOutlet var tintira: UIImageView!
    //@IBOutlet var manchikan: UIImageView!
    //@IBOutlet var rocianblue: UIImageView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------------ここから下にクイズを書く------------------------//
        quizArray.append(["アルパカはなにの仲間？","ラクダ","ウマ","シカ",1])
        quizArray.append(["魚の仲間なのはどれ？","イルカ","イカ","サメ",3])
        quizArray.append(["キリンはなにの仲間？","ウシ","ウマ","ゾウ",1])
        quizArray.append(["スヌーピーのモデルになった犬種は？","チワワ","ダックスフンド","ビーグル",3])
        quizArray.append(["次の中で毎年角が生え替わるのはどれだ？","シカ","ウシ","サイ",1])
        quizArray.append(["かかとを地面に付けないで歩くのはどれだ？","ウサギ","クマ","ウマ",3])

        //------------------------ここから下にクイズを書く------------------------//
        choiceQuiz()
    }
    
    func choiceQuiz() {
        println(quizArray.count)
        //クイズの問題文をシャッフルしてTextViewにセット
        random = Int(arc4random_uniform(UInt32(quizArray.count)))
        quizTextView.text = quizArray[random][0] as! NSString as String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        for var i = 0; i < choiceButtons.count; i++ {
            choiceButtons[i].setTitle(quizArray[random][i+1] as! NSString as String,forState: .Normal)
            
            //どのボタンが押されたか判別するためのtagをセット
            choiceButtons[i].tag = i + 1;
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        println("random \(random)")
        if quizArray[random][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer++
        }
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if sum == questionNumber {
            performSegueToResult()
        }
        quizArray.removeAtIndex(random)
        choiceQuiz()
    }
    
    
    
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            var ResultView : ResultViewController = segue.destinationViewController as! ResultViewController

            ResultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


