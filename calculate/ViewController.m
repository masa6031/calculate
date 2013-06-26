//
//  ViewController.m
//  calculate
//
//  Created by masa on 2013/04/30.
//  Copyright (c) 2013年 masahiro nakagawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    //合計得点保存用(K)

    
    //今回のスコアをUserDefaultsへ保存

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //nendここから
    //画面取得
    UIScreen *sc = [UIScreen mainScreen];
    //ステータスバー込みのサイズ
    CGRect rect = sc.bounds;
    NSLog(@"%.1f", rect.size.height);
    //4インチ用のバナー設置場所
//    if (rect.size.height == 568) {
//        NSLog(@"4インチ");
//        self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0,498,
//                                                                 NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height )];
//    }
//    //3.5インチ用のバナー設置場所
//    if (rect.size.height == 480) {
//        NSLog(@"3.5インチ");
//        // (2) NADView の作成
//        self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0,410,
//                                                                 NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height )];
//    }
//    [self.nadView setIsOutputLog:NO]; // (3)
//    // (4) set apiKey, spotId.
//    [self.nadView setNendID:@"ab32cc0a8b1bad4db913593951b901fbaaf343f6"
//                     spotID:@"49852"];
//  //  [self.nadView setDelegate:self]; //(5)
//    [self.nadView load]; //(6)
//    [self.view addSubview:self.nadView]; // 最初から表示する場合
    //nendここまで
}

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
}

-(IBAction)back:(UIStoryboardSegue *)sender{}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
