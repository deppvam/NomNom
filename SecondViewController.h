//
//  SecondViewController.h
//  NomNom
//
//  Created by TIMGO001 on 4/23/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
//@import FirebaseDatabase;
@interface SecondViewController : UIViewController
@property(weak,nonatomic) IBOutlet UIButton *Registerbtn;
@property(weak,nonatomic) IBOutlet UIButton *LogInbtn;
@property(weak,nonatomic) IBOutlet UITextField* usernameField;
@property(weak,nonatomic) IBOutlet UITextField* passwordField;
//@property (strong, nonatomic) FIRDatabaseReference *ref;
//- (IBAction)registerUser:(id)sender;
- (IBAction)loginUser:(id)sender;


@end
