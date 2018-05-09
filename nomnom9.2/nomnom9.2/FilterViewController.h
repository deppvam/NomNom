//
//  FilterViewController.h
//  nomnom9.2
//
//  Created by Joanna Wang on 4/30/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UISwitch *TypeEnable;
@property (weak, nonatomic) IBOutlet UIButton *oneDollar;
@property (weak, nonatomic) IBOutlet UIButton *twoDollar;
@property (weak, nonatomic) IBOutlet UIButton *threeDollar;
@property (weak, nonatomic) IBOutlet UIButton *fourDollar;
@property (weak, nonatomic) IBOutlet UISlider *distance;
@property (weak, nonatomic) IBOutlet UIButton *applyFilter;
@property (weak, nonatomic) IBOutlet UILabel *distanceValue;
@property (strong, nonatomic) NSMutableArray *liked; //if you send something across views it should be strong?

@end
