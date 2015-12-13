//
//  ViewController.m
//  beacontest
//
//  Created by talpais on 04/12/2015.
//  Copyright © 2015 talpais. All rights reserved.
//

#import "CreateEnvironmentViewController.h"

#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])

@interface CreateEnvironmentViewController ()


@property UIButton* btn1;

@end

@implementation CreateEnvironmentViewController

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    
    
    UILabel* descText = [[UILabel alloc] init];
    descText.frame = CGRectMake(0, 150, screenWidth, 100);
    descText.textAlignment = NSTextAlignmentCenter;
    [descText setFont:[UIFont systemFontOfSize:25.0f]];
    [descText setText:@"please choose environment name:"];
    descText.lineBreakMode = NSLineBreakByWordWrapping;
    descText.numberOfLines = 0;
    [self.view addSubview:descText];
    
    
    UIButton* nextBtn = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth - 150)/2, 350, 150, 70)];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:25.0f]];
    [nextBtn setBackgroundColor:UIColorRGB(0xeeeeee)];
    [nextBtn addTarget:self action:@selector(nextBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextBtnPressed {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
