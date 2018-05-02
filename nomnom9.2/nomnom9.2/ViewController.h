//
//  ViewController.h
//  NomNom
//
//  Created by Joanna Wang on 4/20/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import <CoreLocation/CoreLocation.h>
#import "YelpRequest.h"
#import "ListViewController.h"
#import "FilterViewController.h"


@interface ViewController : UIViewController
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
@property (strong, nonatomic) NSMutableArray *likedFood;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, atomic) NSString *lon;
@property (strong, atomic) NSString *lat;
@property (strong, nonatomic) NSMutableDictionary *requests;
@property (strong, nonatomic) NSMutableDictionary *item;
@property int offset;
@property BOOL reload;

@end
