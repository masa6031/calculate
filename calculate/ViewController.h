//
//  ViewController.h
//  calculate
//
//  Created by masa on 2013/04/30.
//  Copyright (c) 2013年 masahiro nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADView.h"

@interface ViewController : UIViewController
-(IBAction)back:(UIStoryboardSegue *)sender;
@property (nonatomic, strong) NADView * nadView; //nend用
@end
