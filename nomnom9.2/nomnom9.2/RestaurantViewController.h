//
//  RestaurantViewController.h
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "ViewController.h"

@interface RestaurantViewController : ViewController
@property (strong,nonatomic) NSMutableDictionary* resto;
@property (weak, nonatomic) IBOutlet UIImageView *image_url;
@property (weak, nonatomic) IBOutlet UITextView *detail_object;
- (IBAction)sentToYelp:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *restoName;
@property (weak, nonatomic) IBOutlet UITextView *rating;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@end
