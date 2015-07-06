//
//  ViewController.m
//  LoginKeychain
//
//  Created by SDT-B003 on 2015/06/30.
//  Copyright (c) 2015年 Takuya ASO. All rights reserved.
//

#import "ViewController.h"
#import "LUKeychainAccess.h"    // 追加

@interface ViewController ()

// ログインID用
@property (weak, nonatomic) IBOutlet UITextField *loginIDTextField;
- (IBAction)inputAction:(id)sender;

// パスワード用
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
- (IBAction)inputAction2:(id)sender;

// ログインボタン用
- (IBAction)loginAction:(id)sender;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初画面設定
    [self firstSetUp];
}

#pragma mark - First Set Up

- (void)firstSetUp {
    
    NSLog(@"%@", [[LUKeychainAccess standardKeychainAccess] stringForKey:@"LOGINID"]);
    // ログインIDについて
    // LOGIN_ID Key に保存されていなかったら...
    // Placeholder にログインIDと表示
    if (![[LUKeychainAccess standardKeychainAccess] stringForKey:@"LOGINID"]) {
        _loginIDTextField.returnKeyType = UIReturnKeyDefault;
        _loginIDTextField.placeholder = @"ログインID";
        
    } else {
        
    // LOGIN_ID という Key に保存されていたら...
    // 保存されているデータを中に表示
        NSString *loginUserId = [[LUKeychainAccess standardKeychainAccess] stringForKey:@"LOGINID"];
        _loginIDTextField.text = loginUserId;
        
    }
    
    // パスワードについて
    _passwdTextField.returnKeyType = UIReturnKeyDefault;
    _passwdTextField.secureTextEntry = YES;
    _passwdTextField.placeholder = @"パスワード";
}

#pragma mark - Action

- (IBAction)inputAction:(id)sender {
    
    // もし入力がなければエラー表示
    if ([_loginIDTextField.text length] < 1) {
        
        [self alertShortString];
    }
}

- (IBAction)inputAction2:(id)sender {

    // もし入力がなければエラー表示
    if ([_passwdTextField.text length] < 1) {
        
        [self alertShortString];
    }
}

// ログインボタン押した時の処理
- (IBAction)loginAction:(id)sender {

    // ここでログイン処理 (API 叩いたりetc)
    // ここでは組み合わせを決めうちにする。
    // ログインID: funassi, パスワード: nassihh
    
    if ([_loginIDTextField.text isEqualToString:@"funassi"] && [_passwdTextField.text isEqualToString:@"nassihh"]) {
        
        // ログインID，パスワードの登録
        [[LUKeychainAccess standardKeychainAccess] setString:_loginIDTextField.text forKey:@"LOGINID"];
        [[LUKeychainAccess standardKeychainAccess] setString:_passwdTextField.text forKey:@"LOGINPASSWD"];
        
        // 成功したことを記録
        [[LUKeychainAccess standardKeychainAccess] setBool:YES forKey:@"ALREADYLOGIN"];
        
        // 成功画面へ遷移
        [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
        
    } else {
        
        // 失敗アラート
        [self alertFailed];
    }
}

#pragma mark - Alert

- (void)alertShortString {
    
    UIAlertView *av;
    
    // iOS 8 と iOS 7 で書き方が異なる
    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(iOSVersion >= 8.0) {
        
        // コントローラを生成
        UIAlertController *alert_c = [UIAlertController alertControllerWithTitle:@"確認"
                                                                         message:@"入力されていないです。"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        // addAction (ボタン数)
        [alert_c addAction:[UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction *action){
                                                  }]];
        // アラート表示処理
        [self presentViewController:alert_c animated:YES
                         completion:nil];
    } else {
        
        // iOS 7
        av.delegate = self;
        av.title = @"確認";
        av.message = @"入力されていないです。";
        [av addButtonWithTitle:@"OK"];
        [av show];
    }
    
}

- (void)alertFailed {
    
    UIAlertView *av;
    
    // iOS 8 と iOS 7 で書き方が異なる
    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(iOSVersion >= 8.0) {
        
        // コントローラを生成
        UIAlertController *alert_c = [UIAlertController alertControllerWithTitle:@"ログイン失敗"
                                                                         message:@"ログインIDとパスワードの組み合わせが異なります。"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        // addAction (ボタン数)
        [alert_c addAction:[UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction *action){
                                                  }]];
        // アラート表示処理
        [self presentViewController:alert_c animated:YES
                         completion:nil];
    } else {
        
        // iOS 7
        av.delegate = self;
        av.title = @"ログイン失敗";
        av.message = @"ログインIDとパスワードの組み合わせが異なります。";
        [av addButtonWithTitle:@"OK"];
        [av show];
    }
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
