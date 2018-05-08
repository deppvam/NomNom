//
//  loginView.m
//  nomnom9.2
//
//  Log In and defaut opening view
//  Created by Joanna Wang on 4/29/18.
//  Copyright © 2018 NomNom. All rights reserved.
//

#import "loginView.h"
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>

@interface loginView ()
@end
@implementation loginView
@synthesize loginBtn; //unused outside of interface builer
@synthesize signupBtn; //unused outside of interface builer
@synthesize emailText;
@synthesize passwordInput;
@synthesize errorMsg;
@synthesize userid; //unused - in other views, userid is grabbed from firebase instead


- (void)viewDidLoad {
    
    [self.errorMsg setHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// On Pressing Log In, check with Authenticate with firebase.
- (IBAction)loginAction:(id)sender {
    
    [[FIRAuth auth] signInWithEmail:self.emailText.text
                           password:self.passwordInput.text
                         completion:^(FIRUser *user, NSError *error) {
                             if (!error) { //Log In Successful
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
                                     [self.errorMsg setHidden:NO];
                                     [self.errorMsg sizeToFit];
                                    
                                 }
                                 else {
                                     NSLog(@"Other error: %ld",error.code);
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
//Other segue to SignUp view -> Exclusively through Interface Builder. Nothing programmatic required.


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
