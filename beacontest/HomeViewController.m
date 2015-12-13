//
//  ViewController.m
//  beacontest
//
//  Created by talpais on 04/12/2015.
//  Copyright © 2015 talpais. All rights reserved.
//

#import "HomeViewController.h"
#import "CreateEnvironmentViewController.h"
#import "ViewController.h"

#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])

@interface HomeViewController ()


@property UIButton* btn1;

@end

@implementation HomeViewController

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
    
    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 100)];
    [_btn1 setTitle:@"hello" forState:UIControlStateNormal];
    [_btn1 setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:_btn1];
    
    
    UILabel* hello = [[UILabel alloc] init];
    hello.frame = CGRectMake(0, 100, screenWidth, 100);
    hello.textAlignment = NSTextAlignmentCenter;
    [hello setFont:[UIFont boldSystemFontOfSize:40.0f]];
    [hello setText:@"Hello there!"];
    [self.view addSubview:hello];
    
    
    UILabel* noEnvironments = [[UILabel alloc] init];
    noEnvironments.frame = CGRectMake(0, 250, screenWidth, 100);
    noEnvironments.textAlignment = NSTextAlignmentCenter;
    [noEnvironments setFont:[UIFont systemFontOfSize:25.0f]];
    [noEnvironments setText:@"No environment was created,\n please create an environment"];
    noEnvironments.lineBreakMode = NSLineBreakByWordWrapping;
    noEnvironments.numberOfLines = 0;
    [self.view addSubview:noEnvironments];
    
    
    UIButton* createEnvironment = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth - 150)/2, 350, 150, 70)];
    [createEnvironment setTitle:@"Create" forState:UIControlStateNormal];
    [createEnvironment.titleLabel setFont:[UIFont systemFontOfSize:25.0f]];
    [createEnvironment setBackgroundColor:UIColorRGB(0x1080ee)];
    [createEnvironment addTarget:self action:@selector(createEnvironmentPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createEnvironment];
    
    
    UIButton* beaconTest = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth - 120)/2, screenHeight - 50 - 10, 120, 50)];
    [beaconTest setTitle:@"Beacon Test" forState:UIControlStateNormal];
    [beaconTest setBackgroundColor:UIColorRGB(0xee1010)];
    [beaconTest addTarget:self action:@selector(beaconTestPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beaconTest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createEnvironmentPressed {
    CreateEnvironmentViewController* controller1 = [[CreateEnvironmentViewController alloc] init];
    [self presentViewController:controller1 animated:true completion:nil];
}

- (void)beaconTestPressed {
    ViewController* controller1 = [[ViewController alloc] init];
    [self presentViewController:controller1 animated:true completion:nil];
}


@end
