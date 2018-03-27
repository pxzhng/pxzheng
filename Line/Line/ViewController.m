//
//  ViewController.m
//  Line
//
//  Created by pxzheng on 2018/3/27.
//  Copyright © 2018年 zpx. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];

    UIButton *jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 30)];
    [jumpButton setTitle:@"jump" forState:UIControlStateNormal];
    jumpButton.backgroundColor = [UIColor blueColor];
//    jumpButton.layer.borderColor = [UIColor redColor].CGColor;
    jumpButton.layer.borderWidth = 1.0f;
    [jumpButton addTarget:self action:@selector(gotoSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)gotoSecondView:(UIButton *)button{
    SecondViewController *svc = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:svc animated:YES];
    [self presentViewController:svc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
