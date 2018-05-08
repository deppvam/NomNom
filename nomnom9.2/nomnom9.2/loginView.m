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
@synthesize errorMsg;
@synthesize userid;

- (void)viewDidLoad {
    
    [self.errorMsg setHidden:YES];
    [super viewDidLoad];
    NSLog(@"==========Sucessfully loaded logInView==========");
    // Do any additional setup after loading the view.
}
- (IBAction)loginAction:(id)sender {
    
    [[FIRAuth auth] signInWithEmail:emailText.text
                           password:passwordInput.text
                         completion:^(FIRUser *user, NSError *error) {
                             if (!error) {
                                 FIRUser *user = [FIRAuth auth].currentUser;
                                 NSLog(@"user id is: %@\nSending To Main View", user.uid);
                                 
                                  [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                             }
                             else {
                                 if(error.code == FIRAuthErrorCodeUserNotFound) {
                                     self.errorMsg.text = @"Invalid email address, please sign up";
                                     [self.errorMsg sizeToFit];
                                     [self.errorMsg setHidden:NO];
                                 }
                                 else if (error.code == FIRAuthErrorCodeWrongPassword) {
                                     self.errorMsg.text = @"Wrong Password, please try again";
                                     [self.errorMsg sizeToFit];
                                    
                                 }
                             }
                             // ...
                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        NSLog(@"==========Segue to MainView==========");
    }
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
