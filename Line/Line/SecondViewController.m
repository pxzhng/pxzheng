//
//  SecondViewController.m
//  Line
//
//  Created by pxzheng on 2018/3/27.
//  Copyright © 2018年 zpx. All rights reserved.
//

#import "SecondViewController.h"
@class ViewController;
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    [jumpButton setTitle:@"back" forState:UIControlStateNormal];
    jumpButton.backgroundColor = [UIColor blueColor];
//    jumpButton.layer.borderColor = [UIColor redColor].CGColor;
    jumpButton.layer.borderWidth = 1.0f;
    [jumpButton addTarget:self action:@selector(gotoSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    // Do any additional setup after loading the view.
}
-(void)gotoSecondView:(UIButton *)button{
//    SecondViewController *svc = [[SecondViewController alloc] init];
//    [self.navigationController popViewControllerAnimated:YES];
    
//    ViewController *vc = [[NSClassFromString(@"ViewController") alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
//    NSString *web_url = @"http://localhost:63342/h5Demo/0329/test_web.html";
    NSString *web_string = @"http://baidu.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:web_string] options:nil completionHandler:^(BOOL success) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
