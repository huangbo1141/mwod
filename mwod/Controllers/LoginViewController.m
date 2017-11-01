//
//  LoginViewController.m
//  mwod
//
//  Created by BoHuang on 10/31/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "LoginViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "LoginResponse.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (g_isii) {
        self.txtUsername.text = @"Switch It Up Designs 2";
        self.txtPassword.text = @"bbBB22@@";
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLogin:(id)sender {
    NSMutableDictionary*param = [self checkValidate];
    if (param != nil) {
        [CGlobal showIndicator:self];
        NetworkParser* manager = [[NetworkParser alloc] init];
        param[@"mode"] = @"login";
        // NetworkParser
        // https://www.mobilitywod.com/wp-json/custom-plugin/login
        [manager ontemplateGeneralRequest:param Path:@"/wp-json/custom-plugin/login" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (dict != nil) {
                LoginResponse* response = [[LoginResponse alloc] initWithDictionary:dict];
                [CGlobal sharedId].curUser = response.user;
                EnvVar* env = [CGlobal sharedId].env;
                env.lastLogin = [response.user.ID intValue];
                env.username = _txtUsername.text;
                env.password = _txtPassword.text;
                env.nickname = response.user.display_name;
                env.avatar = response.user.avatar;
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [appDelegate registerDeviceUUID];
                [appDelegate goMain];
                
            }else{
                //
                [CGlobal AlertMessage:@"Your username or password is wrong" Title:nil];
            }
            
            [CGlobal stopIndicator:self];
        } method:@"POST"];
    }
}
-(NSMutableDictionary*)checkValidate{
    NSMutableDictionary*ret = [[NSMutableDictionary alloc] init];
    NSString* username = _txtUsername.text;
    NSString* password = _txtPassword.text;
    if ([username length]>0 && [password length]>0) {
        ret[@"username"] = username;
        ret[@"password"] = password;
        return ret;
    }
    if ([username length] == 0) {
        [CGlobal AlertMessage:@"Please Input Username" Title:nil];
    }
    if ([password length] == 0) {
        [CGlobal AlertMessage:@"Please Input Password" Title:nil];
    }
    
    return nil;
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
