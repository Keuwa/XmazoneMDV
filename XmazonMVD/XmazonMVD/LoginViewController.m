//
//  LoginViewController.m
//  XmazonMVD
//
//  Created by Pinson Celine on 15/02/2016.
//  Copyright (c) 2016 Pinson Celine. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SubscribeViewController.h"
#import "OAuth2.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize auth = auth_;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* app_token = [[NSMutableDictionary alloc]initWithDictionary:[userDefaults objectForKey:@"application"]];
    NSMutableDictionary* user_token = [[NSMutableDictionary alloc]initWithDictionary:[userDefaults objectForKey:@"user"]];
    
    ///[app_token setObject:@"azeazaeaze"forKey:@"access_token"];
    self.auth = [[OAuth2 alloc]initWithDictionaryUser:user_token andDictionaryApp:app_token];
}
- (IBAction)tljcn:(id)sender {
    SubscribeViewController* subscribe = [[SubscribeViewController alloc]initWithOauth:self.auth];
    [self.navigationController pushViewController:subscribe animated:YES];

}
- (IBAction)connectionTouch:(id)sender
{
    if( [self.auth connectUserWithLogin:self.loginText.text andPassword:self.passwordText.text] == true )
    {
    HomeViewController* home = [[HomeViewController alloc]initWithOauth:self.auth];
    [self.navigationController pushViewController:home animated:YES];
    
    NSLog( @"%@ %@", self.loginText.text, self.passwordText.text );
    NSLog( @"TOUCH" );
    }
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
