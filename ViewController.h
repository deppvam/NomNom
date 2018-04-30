//
//  ViewController.h
//  NomNom
//
//  Created by Joanna Wang on 4/20/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"
#include <stdlib.h>
@import Firebase;
@import FirebaseDatabase;

@interface ViewController : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

