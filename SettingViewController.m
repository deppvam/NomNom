//
//  SettingViewController.m
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController


@synthesize sliderValue;
@synthesize _priceRange;
@synthesize _foodType;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)_priceRange:(UITextField *)sender {
  NSString *   price = _priceRange.text;
    float fprice = [price floatValue];
    
}



- (IBAction)foodType:(id)sender {
    NSString * food = _foodType.text;
}

- (IBAction)distance:(id)sender {
    int distance = [self sliderValue];
    
}

- (IBAction)applyFilter:(id)sender {
    // if this button is pressed, then it will jump to some other view controllers 
}



- (IBAction)j:(id)sender {
}
@end
