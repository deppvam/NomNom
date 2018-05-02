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
#import "YelpRequest.h"
#import "RestaurantViewController.h"

@interface UserRestaurantsView ()

@end

@implementation UserRestaurantsView
@synthesize saved;
@synthesize ref;
@synthesize user;
@synthesize localUser;
@synthesize savedRestaurants;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //this is heavy in YelpAPI requests... in the future we may want to cache this locally or on Firebase with a timestamp and then flush it if it's older than 24hours
    NSLog(@"saved %@",self.saved);
    savedRestaurants = [[NSMutableDictionary alloc] init];
    for(NSString *obj in self.saved){
        NSDictionary *currResto = [YelpRequest makeRestaurantRequest:obj];
        NSLog(@"Saving... %@",currResto);
        [savedRestaurants setObject:currResto forKey:obj];
        NSLog(@"Retrieving...%@",[savedRestaurants objectForKey:obj]);
    }
    NSLog(@"it shouldn't be null.... %@",savedRestaurants);
    
    
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
    return [self.saved
            count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell1";
    NSLog(@"%@",indexPath);
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *currID=[self.saved objectAtIndex:(int)indexPath.row];
    NSLog(@"currID=%@",currID);
    
    NSDictionary *currResto=[savedRestaurants objectForKey:currID];
    NSLog(@"currResto=%@",currResto);
    
    NSString *name = [currResto objectForKey:@"name"];
    NSLog(@"Restaurant for cell %@ with ID %@ with name %@", indexPath,currID,name);
    cell.textLabel.text=name;
    
    
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[savedRestaurants objectForKey:[self.saved objectAtIndex:(int)indexPath.row]] objectForKey:@"image_url"]]];
    cell.image = [UIImage imageWithData: imageData];
    
    cell.textColor = [UIColor whiteColor];
    return cell;
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromSaved"]) {
        RestaurantViewController *destViewController = segue.destinationViewController;
        UITableViewCell *cell = sender;
        UITableView* table = (UITableView *)[cell superview];
        NSIndexPath* indexPath = [table indexPathForCell:cell];
        
        
        NSLog(@"%@", [NSString stringWithFormat:@"index: %@",indexPath.row]);
        
        
        NSLog(@"Passing dictionary: %@",[self.savedRestaurants objectForKey:[self.saved objectAtIndex: (int)indexPath.row]]);
        NSString *currID=[self.saved objectAtIndex:(int)indexPath.row];
        NSLog(@"currID=%@",currID);
        
        NSDictionary *currResto=[savedRestaurants objectForKey:currID];
        NSLog(@"currResto=%@",currResto);
        
        destViewController.resto = currResto;
        
        NSLog(@"moving to Single Resto view");
        destViewController.segueIden = @"fromSaved";
        destViewController.liked = self.savedRestaurants;
    }
    else if ([segue.identifier isEqualToString:@"backToView"]) {
        ViewController *destViewController = segue.destinationViewController;
        destViewController.likedFood = self.saved;
        
    }
}


@end
