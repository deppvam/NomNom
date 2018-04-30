//
//  UserRestaurantsView.h
//  nomnom9.2
//
//  Created by Joanna Wang on 4/29/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "UserInfo.h"

@interface UserRestaurantsView :UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *saved;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRUser *user;
@property UserInfo *localUser;

@end
