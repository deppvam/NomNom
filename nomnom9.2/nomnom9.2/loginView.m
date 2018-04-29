//
//  loginView.m
//  nomnom9.2
//
//  Created by Joanna Wang on 4/29/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "loginView.h"
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>

@interface loginView ()
@end
@implementation loginView
@synthesize loginBtn;
@synthesize signupBtn;
@synthesize emailText;
@synthesize passwordInput;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loginAction:(id)sender {
    
    [[FIRAuth auth] signInWithEmail:emailText.text
                           password:passwordInput.text
                         completion:^(FIRUser *user, NSError *error) {
                             // ...
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
