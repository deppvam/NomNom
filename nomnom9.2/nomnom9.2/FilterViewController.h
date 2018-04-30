//
//  FilterViewController.h
//  nomnom9.2
//
//  Created by Joanna Wang on 4/30/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UISwitch *TypeEnable;
@property (weak, nonatomic) IBOutlet UILabel *minlabel;
@property (weak, nonatomic) IBOutlet UILabel *maxlabel;





- (IBAction)setMinOne:(id)sender;
- (IBAction)setMinTwo:(id)sender;
- (IBAction)setMinThree:(id)sender;
- (IBAction)setMinFour:(id)sender;
- (IBAction)setMinFive:(id)sender;

- (IBAction)setMaxOne:(id)sender;
- (IBAction)setMaxTwo:(id)sender;
- (IBAction)setMaxThree:(id)sender;
- (IBAction)setMaxFour:(id)sender;
- (IBAction)setMaxFive:(id)sender;
- (IBAction)distanceSlider:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@end
