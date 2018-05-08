//
//  AccountViewController.h
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "UserRestaurantsView.h"
@interface AccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *resetPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewSavedRestaurantsBtn;
@property (weak, nonatomic) IBOutlet UIButton *signoutBtn;
@property (weak, nonatomic) FIRUser *user;
@property (strong, nonatomic) FIRFirestore *db;
@property (strong, nonatomic) NSArray *saved;

@end
