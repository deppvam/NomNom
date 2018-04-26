//
//  ListViewController.m
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "ListViewController.h"
#import "RestaurantViewController.h"
@interface ListViewController ()

@end

@implementation ListViewController
@synthesize liked;
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%i",[self.liked count]);
    
    
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
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"cellToRestaurantSegue"]) {
        RestaurantViewController *destViewController = segue.destinationViewController;
        UITableViewCell *cell = sender;
        UITableView* table = (UITableView *)[cell superview];
        NSIndexPath* indexPath = [table indexPathForCell:cell];
        NSLog([NSString stringWithFormat:@"index: %d",indexPath.row]);
        NSLog([NSString stringWithFormat:@"%@",[[self.liked objectAtIndex: (int)indexPath.row] description]]);
        destViewController.resto = [self.liked objectAtIndex: (int)indexPath.row];
        NSLog(@"moving to Single Resto view");
    }
}



@end
