//
//  MainViewController.m
//  LoginKeychain
//
//  Created by SDT-B003 on 2015/06/30.
//  Copyright (c) 2015年 Takuya ASO. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

// ログアウトボタン用
- (IBAction)logoutAction:(id)sender;

@end


@implementation MainViewController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Action

- (IBAction)logoutAction:(id)sender {

    // ログアウトの処理を書く
    // ここではログイン画面に遷移させる。(Storyboardを分けて実装する時は下記がいいかと)
    // 遷移先の Storyboard 名は？
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 表示させたい View は？
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
    // 遷移のアニメーション
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    // 遷移
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
