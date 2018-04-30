//
//  UserRestaurantsView.m
//  nomnom9.2
//
//  Created by Joanna Wang on 4/29/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "UserRestaurantsView.h"
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
@interface UserRestaurantsView ()

@end

@implementation UserRestaurantsView
@synthesize saved;
@synthesize ref;
@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    self.user = [FIRAuth auth].currentUser;
    if (user) {
        NSString *uid = user.uid;
        NSString *email = user.email;
        NSURL *photoURL = user.photoURL;
    }
    [[[self.ref child:@"userInfo"] child:@"userInfo"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        if (snapshot) {
            [[self.ref child:@"userInfo"] ]
        }
        else {
            
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.liked
            count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *name = [[self.liked objectAtIndex: (int)indexPath.row] objectForKey:@"name"];
    cell.textLabel.text=name;
    
    
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[self.liked  objectAtIndex:(int)indexPath.row] objectForKey:@"image_url"]]];
    cell.image = [UIImage imageWithData: imageData];
    
    
    return cell;
}

@end
