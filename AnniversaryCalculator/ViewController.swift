//
//  ViewController.swift
//  AnniversaryCalculator
//
//  Created by 방선우 on 2022/07/13.
//

import UIKit

class ViewController: UIViewController {
    var dayNumberList = [100, 200, 300, 400] // 표시하고 싶은 기념일 배열 -> 변수로 선언하지 않고 다르게 처리할 수 있는 방법이 없을까
    let formatter = DateFormatter()
    
    @IBOutlet var ImageList: [UIImageView]!
    @IBOutlet weak var myDatePickerStyle: UIDatePicker!
    @IBOutlet var dayList: [UILabel]!
    @IBOutlet var anniversaryDateList: [UILabel]!
    @IBOutlet weak var seletday: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년\nMM월 dd일"
        
        //        if #available(iOS 14.0, *) {
        //            myDatePickerStyle.preferredDatePickerStyle = .inline
        //        }
        // else로 14버전 아래를 처리하면 오류가 뜬다.
        // 컴파일 에러에서 Fix하면 아래처럼 추가하라고 하는데 이러다 모든 버전 다 추가할듯...
        
        // 와우 해결 13.4 버전 이하에서는 .datePickerMode이걸로 써줘야함. -> 모든 버전을 다르게 처리할 수 있게됐따..
        if #available(iOS 14.0, *) {
            myDatePickerStyle.preferredDatePickerStyle = .inline
        } else {
            if #available(iOS 13.4, *) {
                myDatePickerStyle.preferredDatePickerStyle = .wheels
            } else {
                myDatePickerStyle.datePickerMode = .date
            }
        }
        
        setImages(list: ImageList, to: 3)
        
        for i in dayList {
            i.text = "D + \(dayNumberList[i.tag])"
            i.textColor = UIColor.white
            i.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
           // 글자수에 맞게 레이블 크기가 줄어들도록 하는 코드 적기  -> minimum Font Scale
//            anniversaryDateList[i.tag].text = "우리의\n특별한 날"
            anniversaryDateList[i.tag].text = formatter.string(from: seletday.date)
            anniversaryDateList[i.tag].numberOfLines = 2
            anniversaryDateList[i.tag].textAlignment = .center
            anniversaryDateList[i.tag].textColor = UIColor.white// tag 값이 똑같아서 기본값을 같이 지정해주었다.
        }
    }
    
    //MARK: - 메서드 구현
    
    //MARK: 기념일 바꾸기
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        for date in anniversaryDateList { // 기념일이 나오는 레이블입니다
            date.text = plusDay(sender: sender, add: dayNumberList[date.tag])
        }
    }
}

// MARK: 데이트픽커로 날짜를 바꾸면 기념일이 설정되는 액션
func plusDay(sender: UIDatePicker, add: Int) -> String {
    let anniversaryDate = sender.date
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = #"yyyy년\#nMM월 dd일"#
    
    // 클로저를 사용해서 더 간결하게 갈 수 있지 않을까 puls함수를 클로저로 대체..하는...무슨 방법이 있지 ..않을가..
    let plusday = Calendar.current.date(byAdding: .day, value: add, to: anniversaryDate)
    
    return formatter.string(from: plusday!)
}

//MARK: 이미지 넣기 및 이미지에 대한 tag 지정메서드
func setImages(list: [UIImageView]?, to last: Int) {
    
    for i in 0...last {
        list?[i].tag = i
        list?[i].image = UIImage(named: "image\(i)")
        list?[i].layer.cornerRadius = 20
        
        // 그림자 효과 더 알아보기
        
        //
        //        var bulrEffect = UIBlurEffect(style: .dark)
        // var blurView = UIVisualEffectView(effect: bulrEffect)
        //        blurView.frame = list?[i].bounds ?? .
        //
        
        //        list?[i].layer.shadowOffset = .init(width: 178.0, height: 178.0)
        //        list?[i].layer.shadowColor = UIColor.lightGray.cgColor
        //        list?[i].layer.shadowOpacity = 0.6
    }
}

