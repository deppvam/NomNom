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
    self.likedFood = [[[NSUserDefaults standardUserDefaults] objectForKey:@"liked"] mutableCopy];
    
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
    NSLog(@"location got");
    [self initiate_request];
    [self.locationManager stopUpdatingLocation];
    self.item = [self swipeGenerator:self.requests];
    while (self.item == nil){
        self.DescriptionBox.text = @"Loading Yums";
        UIImage *image = [UIImage imageNamed:@"icon"];
        [self.FoodImage setImage: image];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
        self.offset+=50;
        self.requests = [[YelpRequest makeYelpRequest:self.lat long:self.lon radius:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"distance"] limit:50 offset:self.offset] mutableCopy];
        self.item = [self swipeGenerator:self.requests];
    }
        [self setAll:self.item];

    /*
    while ([[self.item objectForKey: @"is_closed"] boolValue] == YES || [self.item objectForKey:@"price"] == nil) {
        self.item = [self swipeGenerator:self.requests];
    }
     */
    //[self setAll:self.item];
    if (!self.likedFood) {
        self.likedFood = [[NSMutableArray alloc] init];
    }
    
}

- (void) initiate_request {
    
    NSLog(@"in initiate request, standeruserdaults distance is: %li", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"distance"]);
    self.requests = [[YelpRequest makeYelpRequest:self.lat long:self.lon radius:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"distance"] limit:50 offset:self.offset] mutableCopy];
    NSLog(@"here");
    
    
    
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
    
    while (self.item == nil){
        NSLog(@"item is nil here");
        self.DescriptionBox.text = @"Loading Yums";
        UIImage *image = [UIImage imageNamed:@"icon"];
        [self.FoodImage setImage: image];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
        self.offset+=50;
        
        self.requests = [[YelpRequest makeYelpRequest:self.lat long:self.lon radius:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"distance"] limit:50 offset:self.offset] mutableCopy];
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
    NSLog(@"in likeAct");
    [self.likedFood addObject:self.item];
    NSLog(@"liked added");
    [self.FoodName setHidden:YES];
    [self.FoodImage setHidden:YES];
    [self.DescriptionBox setHidden:YES];
    self.LikeViewContainer.transform = CGAffineTransformRotate(self.LikeViewContainer.transform, M_PI/2);
    [self.LikeViewContainer setHidden:NO];
    NSString* likedFoodName = self.FoodName.text;
    NSString * message =@"You liked ";
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
    while (self.item == nil){
        self.offset+=50;
        
        self.DescriptionBox.text = @"Loading Yums";
        UIImage *image = [UIImage imageNamed:@"icon"];
        [self.FoodImage setImage: image];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
        self.requests = [[YelpRequest makeYelpRequest:self.lat long:self.lon radius:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"distance"] limit:50 offset:self.offset] mutableCopy];
        self.item = [self swipeGenerator:self.requests];
        
    }/*
    while ([[self.item objectForKey: @"is_closed"] boolValue] == YES || [[self.item objectForKey:@"price"] isEqualToString: @"(null)"]) {
        self.item = [self swipeGenerator:self.requests];
    }
      */

        [self setAll:self.item];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
    
}



- (id)swipeGenerator: (NSMutableDictionary *)allRequests {
    NSMutableArray* keys = [[allRequests allKeys] mutableCopy];
    int size = (int)[allRequests count];
    NSMutableArray *prices = [[NSUserDefaults standardUserDefaults] objectForKey:@"prices"];

    NSLog(@"in swipe generator, size is: %i", size);
    if (size <= 0) {
        self.DescriptionBox.text = @"Loading Yums";
        UIImage *image = [UIImage imageNamed:@"icon"];
        [self.FoodImage setImage: image];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
        self.offset +=50;
        [self.locationManager startUpdatingLocation];
        return nil;
        
    }
    int index = (int) arc4random_uniform(size-1);
    id key = keys[index];
    id item = [allRequests objectForKey:key];
    BOOL pass = NO;
    //NSLog(@"price is: %@", [self.item objectForKey:@"price"]);
    //[allRequests removeObjectForKey:key];
    while (item!=nil && size!=0 && (!pass)) {
        NSLog(@"in the loop, size is: %i", size);
        pass = YES;
        NSLog(@"name is: %@", [item objectForKey:@"name"]);
        [allRequests removeObjectForKey:key];
        keys = [[allRequests allKeys] mutableCopy];
        NSString *price = [item objectForKey:@"price"];
        int priceN = (int)price.length;
        BOOL b =[[NSUserDefaults standardUserDefaults] boolForKey:@"OneTypeSwitch"];
        if (b) {
            NSString *type = [[NSUserDefaults standardUserDefaults] stringForKey:@"type"];
            NSArray *types = [item objectForKey:@"categories"];
            NSLog(@"type is: %@", [types[0] objectForKey:@"title"]);
            if ([[types[0] objectForKey:@"title"] isEqualToString:type] == NO){
                size = (int)[allRequests count];
                if (size == 0) {
                    break;
                }
                pass = NO;
                index = (int) (arc4random() % size);
                key = keys[index];
                item = [allRequests objectForKey:key];
                

                continue;
            }
        }
        if (priceN <= 0 || ![prices[priceN-1] boolValue]) {
            pass = NO;
            size = (int)[allRequests count];
            if(size == 0) {
                break;
            }
            index = (int) (arc4random() % size);
            key = keys[index];
            item = [allRequests objectForKey:key];
            
            continue;
        }
        if ([[self.item objectForKey: @"is_closed"] boolValue] == YES) {
            size = (int)[allRequests count];
            if (size == 0) {
                break;
            }
            pass = NO;
            index = (int) (arc4random() % size);
            key = keys[index];
            item = [allRequests objectForKey:key];
            
            continue;
        }
        NSLog(@"pass is: %i", pass);
        
        size = (int)[allRequests count];
        if (size == 0 && !pass) {
            NSLog(@"the offset is: %i", self.offset);
            self.DescriptionBox.text = @"Loading Yums";
            UIImage *image = [UIImage imageNamed:@"icon"];
            [self.FoodImage setImage: image];
            [self.FoodImage setHidden:NO];
            [self.FoodName setHidden:NO];
            [self.DescriptionBox setHidden:NO];
            //[self.locationManager startUpdatingLocation];
            return nil;
        }
        else if (pass) {
            return item;
            break;
        }
        else {
            size = (int)[allRequests count];
            keys = [[allRequests allKeys] mutableCopy];
            index = (int) (arc4random() % size);
            key = keys[index];
            item = [allRequests objectForKey:key];
        }
        
    }
    if (size == 0) {
        NSLog(@"the offset is: %i", self.offset);
        self.DescriptionBox.text = @"Loading Yums";
        UIImage *image = [UIImage imageNamed:@"icon"];
        [self.FoodImage setImage: image];
        [self.FoodImage setHidden:NO];
        [self.FoodName setHidden:NO];
        [self.DescriptionBox setHidden:NO];
        //[self.locationManager startUpdatingLocation];
        return nil;
    }
    return item;
    /*
    NSString *price = [item objectForKey:@"price"];
    int priceN = (int)price.length;
    NSLog(@"length of prices: %tu",[prices count]);
    NSLog(@"price of the item: %@", price);
    NSLog(@"length of the price: %tu", price.length);
    while (price.length == 0 || item == nil) {
        
        [keys removeObjectAtIndex:index];
        [allRequests removeObjectForKey:key];
        size = (int)[allRequests count];
        if (size <= 0 || item == nil) {
            self.DescriptionBox.text = @"Loading Yums";
            UIImage *image = [UIImage imageNamed:@"icon"];
            [self.FoodImage setImage: image];
            [self.FoodImage setHidden:NO];
            [self.FoodName setHidden:NO];
            [self.DescriptionBox setHidden:NO];
            self.offset +=50;
            [self.locationManager startUpdatingLocation];

            return nil;
        }
        index = (int) (arc4random() % size);
        key = keys[index];
        item = [allRequests objectForKey:key];
        price = [item objectForKey:@"price"];
        priceN = (int)price.length;
    }
    NSLog(@"the testing price is: %i",[prices[priceN-1] boolValue]);
     while (priceN < 1 && [prices[priceN-1] boolValue] == NO) {
        
        [allRequests removeObjectForKey:key];
        [keys removeObjectAtIndex:index];
        size = (int)[allRequests count];
        if (size <= 0 || item == nil) {
            self.DescriptionBox.text = @"Loading Yums";
            UIImage *image = [UIImage imageNamed:@"icon"];
            [self.FoodImage setImage: image];
            [self.FoodImage setHidden:NO];
            [self.FoodName setHidden:NO];
            [self.DescriptionBox setHidden:NO];
            self.offset +=50;
            [self.locationManager startUpdatingLocation];
            return nil;
        }
        index = (int) (arc4random() % size);
        key = keys[index];
        item = [allRequests objectForKey:key];
        price = [item objectForKey:@"price"];
        priceN = (int)price.length;
    }
        BOOL b =[[NSUserDefaults standardUserDefaults] boolForKey:@"OneTypeSwitch"];
        NSLog(@"bool value: %d", b);
        NSLog(@"type value is: %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"type"]);
        
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"OneTypeSwitch"]) {
        NSString *type = [[NSUserDefaults standardUserDefaults] stringForKey:@"type"];;
        while ([self checkType:item :type] == NO) {
            [keys removeObjectAtIndex:index];
            [allRequests removeObjectForKey:key];
            
            size = (int)[allRequests count];
             if (size <= 0 || item == nil) {
                self.DescriptionBox.text = @"Loading Yums";
                UIImage *image = [UIImage imageNamed:@"icon"];
                [self.FoodImage setImage: image];
                [self.FoodImage setHidden:NO];
                [self.FoodName setHidden:NO];
                [self.DescriptionBox setHidden:NO];
                self.offset +=50;
                [self.locationManager startUpdatingLocation];
                return nil;
            }
            index = (int) (arc4random() % size);
            NSLog(@"size is: %i", size);
            NSLog(@"index is: %i", index);
            
            key = keys[index];
            item = [allRequests objectForKey:key];
        }
        
    }
    
    
    //[allRequests removeObjectForKey:key];
    //[keys removeObjectAtIndex:index];
     */
    
}
/*
-(BOOL) checkType: (NSDictionary *) business: (NSString *) type {
    BOOL hasType = NO;
    NSArray *types = [business objectForKey:@"categories"];
    
    for (int i = 0; i < [types count]; i++) {
        //NSLog(@"type is: %@",type);
        //NSLog(@"category is: %@",[types[i] objectForKey:@"title"]);
        if ([[types[i] objectForKey:@"title"] isEqualToString:type]) {
            hasType = YES;
            return YES;
            
        }
    }
    return hasType;
}
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSArray *likedArray =[self.likedFood copy] ;
    //[[NSUserDefaults standardUserDefaults] setObject:likedArray forKey:@"liked"];
    if ([segue.identifier isEqualToString: @"likedFoodSegue"]) {
        ListViewController *destViewController = segue.destinationViewController;
        destViewController.liked = self.likedFood;
        NSLog(@"%lu",(unsigned long)[self.likedFood count]);
        NSLog(@"here");
    }
    if ([segue.identifier isEqualToString: @"goFilter"]) {
        FilterViewController *destViewController = segue.destinationViewController;
        destViewController.liked = self.likedFood;
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
