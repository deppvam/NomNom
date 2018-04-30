//
//  RestaurantViewController.h
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "UserInfo.h"

@interface RestaurantViewController : ViewController
@property (strong,nonatomic) NSMutableDictionary* resto;
@property (weak, nonatomic) IBOutlet UIImageView *image_url;
@property (weak, nonatomic) IBOutlet UITextView *detail_object;
- (IBAction)sentToYelp:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *restoName;
@property (weak, nonatomic) IBOutlet UITextView *rating;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) NSString *segueIden;
@property (weak, nonatomic) NSMutableArray *liked;
@property (strong, nonatomic) FIRFirestore *db;
@property (nonatomic,strong) NSMutableArray *saved;
@property (strong, nonatomic) FIRUser *user;
@property (strong, nonatomic) FIRDocumentReference *ref;
@property UserInfo *localUser;
@end
