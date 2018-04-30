//
//  SettingViewController.h
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "ViewController.h"

@interface SettingViewController : ViewController{
    int slidervalue;
}



- (IBAction)foodType:(id)sender;
- (IBAction)distance:(id)sender;
- (IBAction)applyFilter:(id)sender;

@property (readwrite, assign) int sliderValue;
@property (weak, nonatomic) IBOutlet UITextField *_priceRange;

@property(weak,nonatomic) IBOutlet UITextField* _foodType;
@end
