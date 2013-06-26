//
//  ViewController.m
//  calculate
//
//  Created by masa on 2013/04/30.
//  Copyright (c) 2013年 masahiro nakagawa. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES ];
    
    /************************ここからnendの設定******************************/
    //nendViewのy座標を取得する。
    CGRect rect = self.nendSpace.frame;
    float nendViewY = rect.origin.y;
    
    
    //NADViewの作成
    self.nadView = [[NADView alloc]initWithFrame:CGRectMake(0,nendViewY,
                                                            NAD_ADVIEW_SIZE_320x50.width,
                                                            NAD_ADVIEW_SIZE_320x50.height)];
    [self.nadView setIsOutputLog:NO];
    [self.nadView setNendID:@"3709f3739b04c3efb2220f69eacd7da3f0565270"
                     spotID:@"65982"];
    [self.nadView setDelegate:self];
   // [self.nadView load];
    //[self.view addSubview:self.nadView]; // 最初から表示する場合
    
    /************************ここまでnendの設定******************************/
    
    
    

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
}
/******************ここまでnendの読み込み********************************/

-(IBAction)back:(UIStoryboardSegue *)sender{}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//UIStroyboardSegueのsegueの名前が入る
//prepareForSegueで遷移元から遷移先に移すメソッド
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //[segue identifier] でセグエの文字列を取得して、isEqualToStringで文字列を比較
    if ([[segue identifier] isEqualToString:@"showSecond"]) {
        CGRect rect = self.nendSpace.frame;
        int nendViewY = rect.origin.y;
        NSLog(@"取得した値は：%d",nendViewY);
        //遷移先のsegueの情報を取得して、*viewControllerに入れる
        SecondViewController *viewController = [segue destinationViewController];
        //viewControllerの中にあるnumに値を渡す
        viewController.num = nendViewY;
    }
}
- (void)viewDidUnload {
    [self setNendSpace:nil];
    [super viewDidUnload];
}
//おすすめアプリのボタンを押したら
- (IBAction)tapAdsButton:(UIButton *)sender {
    NSLog(@"ボタンが押されました");
    AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [GFController showGF:self site_id:@"1198" delegate: appDelegate];
}
// UIApplicationDelegateを継承したクラスに設定
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        backgroundSupported = device.multitaskingSupported;
    }
    if (backgroundSupported) {
        [GFController backgroundTask];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [GFController conversionCheckStop];
}
@end
