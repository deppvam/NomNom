//
//  SecondViewController.m
//  NomNom
//
//  Created by TIMGO001 on 4/23/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "SecondViewController.h"
#import <Firebase/Firebase.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (IBAction)RegisterButton:(id)sender {
    
    if((!_usernameField.text || [_usernameField.text isEqualToString:@""]) && (!_passwordField.text || [_passwordField.text isEqualToString:@""])){
        NSString * message = @"You need to enter username and password";
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [error addAction:action];
        [self presentViewController:error animated:YES completion:nil];
        
    }
     else if(!_usernameField.text || [_usernameField.text isEqualToString:@""]){
        NSString * message = @"You need to enter username";
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [error addAction:action];
        [self presentViewController:error animated:YES completion:nil];
        
    }
     else if(!_passwordField.text || [_passwordField.text isEqualToString:@""]){
         NSString * message = @"You need to enter password";
         UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:message preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
         [error addAction:action];
         [self presentViewController:error animated:YES completion:nil];
         
         
     }
    //put code about creating new users here
    else{
    NSLog(@"This line has been activated");
    [[FIRAuth auth] createUserWithEmail:_usernameField.text
                               password:_passwordField.text
                             completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                 
       NSLog(@"We have created your account");
                                 
                             }];
    }
    
}

- (IBAction)LoginButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:@"Registered"]){
        NSLog(@"No registered user");
        _LogInbtn.hidden = YES;
    }
    else{
        NSLog(@"This user has already registered");
        _Registerbtn.hidden = YES;
    }
    // Do any additional setup after loading the view.
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

- (IBAction)account:(id)sender {
}

- (IBAction)password:(id)sender {
}
- (IBAction)userna:(id)sender {
}
/*
- (IBAction)registerUser:(id)sender {
    if([_usernameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""]){
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Be Careful" message:@"You need to enter both username and password" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:error animated:YES completion:nil];
        
    }
    //put code about creating new users here
    NSLog(@"This line has been activated");
    [[FIRAuth auth] createUserWithEmail:_usernameField.text
                               password:_passwordField.text
                             completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                 // ...
                                 
                                 
                             }];
    
 
} */
-(void)registerNewUser{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_usernameField.text forKey:@"username"];
    [defaults setObject:_passwordField.text forKey:@"password"];
    [defaults setBool:YES forKey:@"Registered"];
    
    [defaults synchronize];
    
    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Sucess" message:@"Thank you for choosing NomNom" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:success animated:YES completion:nil];
    
    [self performSegueWithIdentifier:@"Log in" sender:self];

}



- (IBAction)loginUser:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // check username/password != nil
    if([_usernameField.text isEqualToString:[defaults objectForKey:@"username" ]] &&[_passwordField.text isEqualToString:[defaults objectForKey:@"password"]] ){
        NSLog(@"You have logged in");
        _usernameField = nil;
        _passwordField = nil;
        [self performSegueWithIdentifier:@"log-in" sender:self];
        // retrieve data from this particular user
        [[FIRAuth auth] signInWithEmail:_usernameField.text
                               password:_passwordField.text
                             completion:^(FIRUser *user, NSError *error) {
                                // self.ref = [[FIRDatabase database] reference];
                                 //NSString *userID = [FIRAuth auth].currentUser.uid;
                               
                             }];
        
    }
    else{
        UIAlertController *error = [UIAlertController  alertControllerWithTitle:@"Error" message:@"Your username or password is incorrect" preferredStyle:UIAlertControllerStyleAlert];
         [self presentViewController:error animated:YES completion:nil];
       
        
    }
}
@end
