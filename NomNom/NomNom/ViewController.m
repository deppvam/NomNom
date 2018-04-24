//
//  ViewController.m
//  NomNom
//
//  Created by Joanna Wang on 4/20/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "ViewController.h"
#import "YelpRequest.h"
#include <stdlib.h>
#import <UIKit/UIKit.h>
#import "FoodInfo.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *LikeViewContainer;
@property (weak, nonatomic) IBOutlet UILabel *LikedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *LikedImage;
@property (weak, nonatomic) IBOutlet UIButton *SettingBtn;
@property (weak, nonatomic) IBOutlet UIButton *AccountBtn;
@property (weak, nonatomic) IBOutlet UIButton *LikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *DislikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *ListsBtn;
@property (weak, nonatomic) IBOutlet UIImageView *FoodImage;
@property (weak, nonatomic) IBOutlet UILabel *FoodName;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionBox;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *LeftSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *RightSwipe;
@property (strong, nonatomic) NSMutableDictionary *food;
@property (strong, nonatomic) NSMutableDictionary *likedFood;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, atomic) NSString *lon;
@property (strong, atomic) NSString *lat;
@property (strong, nonatomic) NSDictionary *requests;
@end

@implementation ViewController

- (void)viewDidLoad {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services are not enabled");
    }
    
    self.requests = [YelpRequest makeYelpRequest:self.lat long:self.lon radius:3000 limit:50 offset:0];
    // load all the information about the food
    [self.LikeViewContainer setHidden:YES];
    [self.LikedLabel setHidden:YES];
    [self.LikedImage setHidden:YES];
    self.food = [[NSMutableDictionary alloc] init];
    UIImage *image = [UIImage imageNamed:@"Ramen.jpeg"];
    [self Add_Item: @"Tasty Ramen!" :@"Ramen" :image];
    image = [UIImage imageNamed:@"cupcake.jpg"];
    [self Add_Item: @"Fancy Cupcakes" :@"Cupcake" :image];
    FoodInfo *item = [self swipeGenerator:self.food];
    [self.FoodImage setImage: item.Image];
    self.FoodName.text = item.FoodName;
    self.DescriptionBox.text = item.Description;
   [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = [locations lastObject];
    self.lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.lon = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSLog(@"latitude is %@", self.lat);
    NSLog(@"longitude is %@", self.lon);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)leftSwipeAction:(id)sender {
    FoodInfo *item = [self swipeGenerator:self.food]; 
    [self.FoodImage setImage: item.Image];
    self.FoodName.text = item.FoodName;
    self.DescriptionBox.text = item.Description;
    
}
- (IBAction)rightSwipeAction:(id)sender {
    self.LikeViewContainer.transform = CGAffineTransformRotate(self.LikeViewContainer.transform, M_PI/2);
    [self.LikeViewContainer setHidden:NO];
    NSString* likedFoodName = self.FoodName.text;
    NSString * message = [[NSString alloc] initWithString:@"You liked "];
    self.LikedLabel.text= [message stringByAppendingString:likedFoodName];
    
    [self.LikedImage setImage:self.FoodImage.image];
    [self.LikedLabel setHidden:NO];
    [self.LikedImage setHidden:NO];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.LikeViewContainer addGestureRecognizer:singleFingerTap];
    
    //The event handling method
 
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    [self.LikeViewContainer setHidden:YES];
    [self.LikedLabel setHidden:YES];
    [self.LikedImage setHidden:YES];
    FoodInfo *item = [self swipeGenerator:self.food];
    [self.FoodImage setImage: item.Image];
    self.FoodName.text = item.FoodName;
    self.DescriptionBox.text = item.Description;
    //Do stuff here...
}


- (id)swipeGenerator: (NSMutableDictionary *)allFood {
    NSArray* keys = [allFood allKeys];
    int size = [keys count];

    NSLog(@"%i", size);
    int index = (int) arc4random_uniform(size-1);
    id key = keys[index];
    NSLog(key);
    id item = [allFood objectForKey:key];
    int count = 0;
    while (item == nil && count != size) {
        index = (int) arc4random() % (size);
        key = keys[index];
        item = [allFood objectForKey:key];
        count++;
    }
    if (count == size) {
        return nil;
    }
    [allFood removeObjectForKey:key];
    return item;
}


- (void) Add_Item: (NSString*) Name : (NSString*) s : (UIImage*) image{
    id myObject = [[FoodInfo alloc] init];
    [myObject set_Obj:s : Name : image];
    [self.food setObject:myObject forKey:Name];
}

@end
