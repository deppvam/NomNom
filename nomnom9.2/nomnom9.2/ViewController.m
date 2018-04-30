//
//  ViewController.m
//  NomNom
//
//  Created by Joanna Wang on 4/20/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "YelpRequest.h"
#include <stdlib.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController () <CLLocationManagerDelegate>

@end

@implementation ViewController
@synthesize LikeViewContainer;
@synthesize LikedLabel;
@synthesize LikedImage;
@synthesize SettingBtn;
@synthesize AccountBtn;
@synthesize LikeBtn;
@synthesize DislikeBtn;
@synthesize ListsBtn;
@synthesize FoodImage;
@synthesize FoodName;
@synthesize DescriptionBox;
@synthesize LeftSwipe;
@synthesize RightSwipe;
@synthesize likedFood;
@synthesize locationManager;
@synthesize lon;
@synthesize lat;
@synthesize requests;
@synthesize item;
@synthesize offset;

- (void)viewDidLoad {
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.offset = 0;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
        [self.locationManager stopUpdatingLocation];
    } else {
        NSLog(@"Location services are not enabled");
    }
    
    
    
    
    //self.requests = [YelpRequest makeYelpRequest:self.lat long:self.lon radius:3000 limit:50 offset:0];
    // load all the information about the food
    [self.LikeViewContainer setHidden:YES];
    [self.LikedLabel setHidden:YES];
    [self.LikedImage setHidden:YES];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location = [locations lastObject];
    self.lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.lon = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    [self initiate_request];
    [self.locationManager stopUpdatingLocation];
    
}

- (void) initiate_request {
    int radi = [[NSUserDefaults standardUserDefaults] integerForKey:@"distance"];
    int minP = [[NSUserDefaults standardUserDefaults] integerForKey:@"minPrice"];
    int maxP = [[NSUserDefaults standardUserDefaults] integerForKey:@"maxPrice"];
    self.requests = [[YelpRequest makeYelpRequest:self.lat long:self.lon radius:radi limit:50 offset:self.offset min:minP max:maxP] mutableCopy];
    self.item = [self swipeGenerator:self.requests];
    
    while ([[self.item objectForKey: @"is_closed"] boolValue] == YES || [[self.item objectForKey:@"price"] isEqualToString: @"(null)"]) {
        self.item = [self swipeGenerator:self.requests];
    }
    [self setAll:self.item];
    if (!self.likedFood) {
        self.likedFood = [[NSMutableArray alloc] init];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftSwipeAction:(id)sender {
    
    [self dislikeAct];
    
    
    
    
}

-(void) dislikeAct {

    self.item = [self swipeGenerator:self.requests];
    while ([[self.item objectForKey: @"is_closed"] boolValue] == YES || [[self.item objectForKey:@"price"] isEqual: @"(null)"]) {
        self.item = [self swipeGenerator:self.requests];
    }
    [self setAll:self.item];
    
}

- (void) setAll: (NSMutableDictionary*) business {
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [business objectForKey:@"image_url"]]];
    [self.FoodImage setImage: [UIImage imageWithData: imageData]];
    NSArray *typeFood = [business objectForKey:@"categories"];
    self.FoodName.text = [typeFood[0] objectForKey:@"title"];
    NSMutableAttributedString *description = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Restaurant: \t\t%@",[business objectForKey:@"name"]]];
    //Begin Appending Yelp Branding... for ratings
    [description appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\nYelp Rating: \t\t"]];
    //NSMutableAttributedString *description = [[NSMutableAttributedString alloc] initWithString:@"\nYelp Rating: \t\t"];
    
    NSString *rating =[business objectForKey:@"rating"];
    
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];

    imageAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",rating]];
    CGFloat imageOffsetY = -5.0;
    imageAttachment.bounds = CGRectMake(0, imageOffsetY, imageAttachment.image.size.width, imageAttachment.image.size.height);
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [description appendAttributedString:attachmentString];
    //End Yelp Branding
    
    //[description appendFormat:@"%@\n", [business objectForKey:@"rating"]];
    
    [description appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\nPrice:\t\t\t%@",[business objectForKey:@"price"]]]];
    //[description appendFormat:[NSString@"Price: %@\n", [business objectForKey:@"price"]]];
    
    float d = [[business objectForKey:@"distance"] floatValue];
    d = d/1600;
    d = floorf(d * 100 + 0.5) / 100;
    NSNumber *distance = [NSNumber numberWithFloat:d];
    [description appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\nDistance:\t\t\t%@ miles",distance]]];
    //[description appendFormat:@"Distance: %@ miles\n", distance];
    self.DescriptionBox.attributedText = description;
    self.DescriptionBox.textColor = [UIColor whiteColor];

}

- (IBAction)rightSwipeAction:(id)sender {
    [self likeAct];
    
    //The event handling method
    
    
}

- (void)likeAct {
    [self.likedFood addObject:self.item];
    [self.FoodName setHidden:YES];
    [self.FoodImage setHidden:YES];
    [self.DescriptionBox setHidden:YES];
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
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.LikeViewContainer setHidden:YES];
    [self.LikedLabel setHidden:YES];
    [self.LikedImage setHidden:YES];
    self.item = [self swipeGenerator:self.requests];
    while ([[self.item objectForKey: @"is_closed"] boolValue] == YES || [[self.item objectForKey:@"price"] isEqualToString: @"(null)"]) {
        self.item = [self swipeGenerator:self.requests];
    }
    [self setAll:self.item];
    [self.FoodImage setHidden:NO];
    [self.FoodName setHidden:NO];
    [self.DescriptionBox setHidden:NO];
    
}



- (id)swipeGenerator: (NSMutableDictionary *)allRequests {
    NSArray* keys = [allRequests allKeys];
    int size = [keys count];
    NSLog(@"size is: %i", size);
    if (size == 0) {
        self.DescriptionBox.text = @"Loading Yums";
        UIImage *image = [UIImage imageNamed:@"icon"];
        [self.FoodImage setImage: image];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
        self.offset +=50;
        [self.locationManager startUpdatingLocation];
        [self.locationManager stopUpdatingLocation];
        return nil;
        
    }
    int index = (int) arc4random_uniform(size-1);
    id key = keys[index];
    id item = [allRequests objectForKey:key];
    NSLog(@"price is: %@", [self.item objectForKey:@"price"]);
    
    while (item == nil && size!=0) {
        index = (int) arc4random() % (size);
        key = keys[index];
        item = [allRequests objectForKey:key];
    }
    
    [allRequests removeObjectForKey:key];
    
    return item;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"likedFoodSegue"]) {
        ListViewController *destViewController = segue.destinationViewController;
        destViewController.liked = self.likedFood;
        NSLog(@"%i",[self.likedFood count]);
        NSLog(@"here");
    }
}

- (IBAction)clickLike:(id)sender {
    [self likeAct];
}

- (IBAction)clickDislike:(id)sender {
    [self dislikeAct];
}


-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}



@end
