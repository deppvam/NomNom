//
//  signupView.m
//  nomnom9.2
//
//  Created by Joanna Wang on 4/29/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "signupView.h"

@interface signupView ()

@end

@implementation signupView
@synthesize emailText;
@synthesize passwordText;
@synthesize confirmPassword;
@synthesize SignUpButton;
@synthesize errorMsg;
- (void)viewDidLoad {
    [self.errorMsg setHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)signupAction:(id)sender {
    if (!self.emailText.text || self.emailText.text.length ==0) {
        self.errorMsg.text = @"Please enter email";
        [self.errorMsg sizeToFit];
        [self.errorMsg setHidden:NO];
    }
    else if (!self.passwordText.text|| self.passwordText.text.length ==0) {
        self.errorMsg.text = @"Please enter password";
        [self.errorMsg sizeToFit];
        [self.errorMsg setHidden:NO];
    }
    else if (![self.passwordText.text isEqualToString:self.confirmPassword.text]) {
        
        self.errorMsg.text = @"Passwords are not the same\nPlease enter again";
        self.errorMsg.lineBreakMode = NSLineBreakByWordWrapping;
        self.errorMsg.numberOfLines = 2;
        [self.errorMsg sizeToFit];
        [self.errorMsg setHidden:NO];
        self.passwordText.text = nil;
        self.confirmPassword.text = nil;
    }
    else {
        [[FIRAuth auth] createUserWithEmail:self.emailText.text
                                   password:self.passwordText.text
                                 completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                     if (!error) {
                                         UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Sign Up Success"
                                                                                                       message:@"Take me to log in!"
                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                                         
                                         UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes, please"
                                                                                             style:UIAlertActionStyleDefault
                                                                                           handler:^(UIAlertAction * action)
                                         {
                                             [self performSegueWithIdentifier:@"signupSuccess" sender:nil];
                                         }];
                                         [alert addAction:yesButton];
                                         [self presentViewController:alert animated:YES completion:nil];
                                     }
                                     else {
                                         
                                     }
                                 }];
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
