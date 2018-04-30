//
//  ThirdViewController.h
//  NomNom
//
//  Created by TIMGO001 on 4/24/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabase;
@interface ThirdViewController : UIViewController
- (IBAction)logout:(id)sender;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
