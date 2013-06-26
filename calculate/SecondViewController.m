//
//  SecondViewController.m
//  calculate
//
//  Created by masa on 2013/04/30.
//  Copyright (c) 2013年 masahiro nakagawa. All rights reserved.
//

#import "SecondViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#define CONST_INT 30 
//ゲーム時間の定数

@interface SecondViewController ()

@end

@implementation SecondViewController
{
    float startCount;

    NSString *str;
    int x1,x2,ans,count,counter,theRight,missCount;
    float timeCounter;
    NSTimer *tm;
    BOOL questionFlag;
    NSMutableArray *rankingArray;
    
    
    //rannkingを表示させる為のインスタンス
    NSArray *no;
    NSUserDefaults *defaults;
    int no1,no2,no3;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    /***********************NENDの設定**************************/
    //画面サイズの取得
    UIScreen *sc = [UIScreen mainScreen];
    //ステータスバー込みのサイズ
    CGRect rect = sc.bounds;
    //4インチ用の場合はバナーを設置する。
    if(rect.size.height == 568){
        /************************ここからnendの設定******************************/
        //nendViewのy座標を取得する。
        
        //NADViewの作成
        self.nadView2 = [[NADView alloc]initWithFrame:CGRectMake(0,244,
                                                                NAD_ADVIEW_SIZE_320x50.width,
                                                                NAD_ADVIEW_SIZE_320x50.height)];
        [self.nadView2 setIsOutputLog:NO];
        [self.nadView2 setNendID:@"3709f3739b04c3efb2220f69eacd7da3f0565270"
                         spotID:@"65982"];
        [self.nadView2 setDelegate:(id)self];
        [self.nadView2 load];
        [self.view addSubview:self.nadView2]; // 最初から表示する場合
        
        /************************ここまでnendの設定******************************/;
    }else if(rect.size.height == 480){
        NSLog(@"3.5インチです。");
    }
    
    
    /***********************NENDの設定**************************/
    NSLog(@"取得した値は：%d",self.num);
    no1 = no2 = no3 = 0;
    
    defaults = [NSUserDefaults standardUserDefaults];
    no1 = [defaults integerForKey:@"NO1"];
    no2 = [defaults integerForKey:@"NO2"];
    no3 = [defaults integerForKey:@"NO3"];
    

    [self.navigationController setNavigationBarHidden:YES];
    self.endView.alpha = 0;
    self.nendSpace.alpha = 0;
    self.ansLabel.alpha = 1;
    count = 0;
    counter = 0;
    self.counterLabel.text = @"0/10";
    x1 = 1 + arc4random() % 8;
    x2 = 1 + arc4random() % 8;
    //開始時に音を出す
//    AudioServicesPlayAlertSound(1008);
    self.rankingLabel.hidden = YES;
    
    self.questionLabel.text = [NSString stringWithFormat:@"%d + %d",x1,x2];
    
    //ranking用


    self.timeLabel.text = [NSString stringWithFormat:@"%d:00",CONST_INT];
}
/******************ここからnendの読み込み********************************/
//nend広告ロード完了通知
-(void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"delegate nadViewDidFinishLoad:");
}
//nend広告受信完了通知
-(void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"delegate nadViewDidReceiveAd:");
}
//nend広告受信エラー通知
-(void)nadViewDidFailToReceiveAd:(NADView *)adView {
    NSLog(@"delegate nadViewDidFailToLoad:");
}
//広告の対策
-(void)dealloc
{
    self.nadView.delegate = nil;
    self.nadView2.delegate = nil;
}
/******************ここからnendの読み込み********************************/
//タイマー処理
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    questionFlag = YES;
    missCount = 0;
    startCount = 0;
    timeCounter = CONST_INT;
    self.questionLabel.alpha = 0.0;
    self.startLabel.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    self.startLabel.alpha = 0.0;
    [UIView commitAnimations];
    
    
    
    tm = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeCount:) userInfo:nil repeats:YES];
}
//タイマー処理
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [tm invalidate];
}
//タイマー処理
-(void)timeCount:(NSTimer *)timer
{
    if(startCount < 1.8){
    startCount += 0.01;
    }
    
    if(startCount > 1.8){
        if(questionFlag)
        {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7];
        self.questionLabel.alpha = 1.0;
        [UIView commitAnimations];
            questionFlag = NO;
        }
        //タイムが残り１０秒になったら文字の色を赤くする。
        if(timeCounter < 10)
            self.timeLabel.textColor = [UIColor redColor];
        
    //ゲーム時間が終わったら呼び出される
    if(timeCounter <= 0.00)
    {
        //タイマーを停止する。
        [tm invalidate];
        self.nadView2.hidden = YES;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        self.endView.alpha = 1.0;
        self.nendSpace.alpha = 1.0;
        [UIView commitAnimations];
        self.theLightLabel.text = [NSString stringWithFormat:@"正解数：%d 問",theRight];
        self.missLabel.text = [NSString stringWithFormat:@"ミス数：%d 問",missCount];
        
        //self.timerCount.text = [NSString stringWithFormat:@"タイム：%d:00 秒",CONST_INT];
        
        /************************ここからnendの設定******************************/
        //nendViewのy座標を取得する。
        CGRect rect = self.nendSpace.frame;
        float nendViewY = rect.origin.y;
        NSLog(@"%f",nendViewY);
        
        //NADViewの作成
        self.nadView = [[NADView alloc]initWithFrame:CGRectMake(0,self.num,
                                                                NAD_ADVIEW_SIZE_320x50.width,
                                                                NAD_ADVIEW_SIZE_320x50.height)];
        [self.nadView setIsOutputLog:NO];
        [self.nadView setNendID:@"3709f3739b04c3efb2220f69eacd7da3f0565270"
                         spotID:@"65982"];
        [self.nadView setDelegate:(id)self];
        [self.nadView load];
        [self.view addSubview:self.nadView]; // 最初から表示する場合
        
        /************************ここまでnendの設定******************************/
        
        //rankingのメソッドを呼び出す。
        [self rankingMedhod];
    }
    timeCounter -= 0.01;
        
        
    //取得したタイムを"."で区切って配列に入れている
    NSArray *timerValue = [[NSString stringWithFormat:@"%.2f",fabs(timeCounter)]  componentsSeparatedByString:@"."];
        
        self.timeLabel.text =[NSString stringWithFormat:@"%@:%@",timerValue[0],timerValue[1]];
        if(timeCounter < 0)
        self.timeLabel.text = @"0:00";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//答えが正解したとき、規定数入力されたときに実行される。
-(void)reset
{
         //正解したとき実行される
         if(x1+x2 == [self.ansLabel.text intValue])
        {
            theRight++;
            
            //GOODのアニメーション実行
            _answerImage.alpha = 1.0;
            self.answerImage.image = [UIImage imageNamed:@"ico_second_good"];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.7];
            self.answerImage.alpha = 0;
            self.ansLabel.alpha = 0;
            [UIView commitAnimations];
        }
         else
         {
             missCount++;
             _answerImage.alpha = 1.0;
             self.answerImage.image = [UIImage imageNamed:@"ico_second_bad"];
             [UIView beginAnimations:nil context:nil];
             [UIView setAnimationDuration:0.7];
             self.answerImage.alpha = 0;
             self.ansLabel.alpha = 0;
             [UIView commitAnimations];
         }
        self.ansLabel.textColor = [UIColor blueColor];
        x1 = 1 + arc4random() % 8;
        x2 = 1 + arc4random() % 8;
        self.questionLabel.text = [NSString stringWithFormat:@"%d + %d",x1,x2];
        count = 0;
        counter ++;
        self.counterLabel.text = [NSString stringWithFormat:@"%d/10",counter];

}
- (IBAction)tapNumberButton:(id)sender {

    if(startCount > 1.8){
    UIButton *button = (UIButton *)sender;
    
    
    self.ansLabel.alpha = 1.0;
    //文字の打ちはじめで初期化する
    if(count == 0)
    {
        self.ansLabel.text = @"";
        self.ansLabel.textColor = [UIColor blackColor];
    }

    count ++;
      str = [NSString stringWithFormat:@"%d",button.tag];
    self.ansLabel.text = [self.ansLabel.text stringByAppendingString:str];
    
        //ansLabelの最初の文字が0の場合
    if([self.ansLabel.text isEqualToString:@"0"])
        [self reset];
    //答えが一桁で正解した場合に実行される。
    else if( x1+x2 == button.tag)
        [self reset];
    //答えが一桁で不正解したときに実行される。
    else if( x1+x2 < 10 && x1+x2 != button.tag)
        [self reset];
    
    //ansLabelに２文字うたれたら、次の問題へ進む
    if(count == 2)
        [self reset];
    
    }

}
//ランキングを表示させるメソッド
-(void)rankingMedhod
{
    //得点のクラス
    int score = 0;
    switch (missCount) {
        case 0:
            score = theRight * 1101;
            NSLog(@"%d",score);
            break;
        case 1:
            score = theRight * 1072;
            NSLog(@"%d",score);
            NSLog(@"ミスは1");
            break;
        case 2:
            score = theRight * 1053;
            NSLog(@"%d",score);
            NSLog(@"ミスは2");
            break;
        case 3:
            score = theRight * 1034;
            NSLog(@"%d",score);
            NSLog(@"ミスは3");
            break;
        default:
            score = theRight * 1001;
            NSLog(@"%d",score);
            break;
    }
    self.timerCount.text = [NSString stringWithFormat:@"得点：%d",score];
    
    
    if(no1 < score)
    {
        [defaults setInteger:no2 forKey:@"NO3"];
        [defaults setInteger:no1 forKey:@"NO2"];
        [defaults setInteger:score forKey:@"NO1"];
        NSLog(@"---------1位--------------");
        NSLog(@"%d",[defaults integerForKey:@"NO1"]);
        NSLog(@"%d",[defaults integerForKey:@"NO2"]);
        NSLog(@"%d",[defaults integerForKey:@"NO3"]);
        self.no1Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO1"]];
        self.no2Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO2"]];
        self.no3Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO3"]];
        
//        self.no1Label.textColor = [UIColor greenColor];
        self.rankingLabel.text = @"最短記録更新\n1位にランクイン!!!";
        self.rankingLabel.hidden = NO;
        
    }
    else if(no2 < score)
    {
        [defaults setInteger:no2 forKey:@"NO3"];
        [defaults setInteger:score forKey:@"NO2"];
        NSLog(@"---------2位--------------");
        NSLog(@"%d",[defaults integerForKey:@"NO1"]);
        NSLog(@"%d",[defaults integerForKey:@"NO2"]);
        NSLog(@"%d",[defaults integerForKey:@"NO3"]);
        self.no1Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO1"]];
        self.no2Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO2"]];
        self.no3Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO3"]];
//        self.no2Label.textColor = [UIColor greenColor];
        self.rankingLabel.text = @"最短記録更新\n2位にランクイン!!!";
        self.rankingLabel.hidden = NO;
        
    }
    else if(no3 < score)
    {
        [defaults setInteger:score forKey:@"NO3"];
        NSLog(@"---------3位--------------");
        NSLog(@"%d",[defaults integerForKey:@"NO1"]);
        NSLog(@"%d",[defaults integerForKey:@"NO2"]);
        NSLog(@"%d",[defaults integerForKey:@"NO3"]);
        self.no1Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO1"]];
        self.no2Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO2"]];
        self.no3Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO3"]];
//        self.no3Label.textColor = [UIColor greenColor];
        self.rankingLabel.text = @"最短記録更新\n3位にランクイン!!!";
        self.rankingLabel.hidden = NO;
    }else{
        NSLog(@"何もなし");
        self.no1Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO1"]];
        self.no2Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO2"]];
        self.no3Label.text = [NSString stringWithFormat:@"%d",[defaults integerForKey:@"NO3"]];
        self.rankingLabel.text = @"";
    }
    
}

- (void)viewDidUnload {
    [self setRankingLabel:nil];
    [self setNendSpace:nil];
    [super viewDidUnload];
}
@end














