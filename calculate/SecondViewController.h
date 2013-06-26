//
//  SecondViewController.h
//  calculate
//
//  Created by masa on 2013/04/30.
//  Copyright (c) 2013年 masahiro nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADView.h"

@interface SecondViewController : UIViewController
- (IBAction)tapNumberButton:(id)sender;
@property (nonatomic,assign)int num;
@property (weak, nonatomic) IBOutlet UILabel *ansLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIView *endView;
@property (weak, nonatomic) IBOutlet UILabel *theLightLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerCount;
@property (weak, nonatomic) IBOutlet UIImageView *answerImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *missLabel;

//ランキングラベル
@property (weak, nonatomic) IBOutlet UILabel *no1Label;
@property (weak, nonatomic) IBOutlet UILabel *no2Label;
@property (weak, nonatomic) IBOutlet UILabel *no3Label;
@property (weak, nonatomic) IBOutlet UILabel *no4Label;
@property (weak, nonatomic) IBOutlet UILabel *no5Label;
@property (weak, nonatomic) IBOutlet UIView *iAdView;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nendSpace;
@property (nonatomic,retain)NADView *nadView;

@end
