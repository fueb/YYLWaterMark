//
//  ViewController.m
//  waterMarkDemo
//
//  Created by yyl on 2020/9/25.
//  Copyright © 2020 yyl. All rights reserved.
//

#import "ViewController.h"
#import "YYLWaterMark.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showWaterImg];
}

- (void)showWaterImg
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:imgView];
    imgView.backgroundColor = [UIColor redColor];
    NSString*path = [[NSBundle mainBundle]pathForResource:@"choiceBg" ofType:@"png"];
    imgView.image = [YYLWaterMark watermarkImage:[UIImage imageWithContentsOfFile:path] withName:@"测试水印" withFontSize:20 withAngle:(M_PI / 8)];
}

@end
