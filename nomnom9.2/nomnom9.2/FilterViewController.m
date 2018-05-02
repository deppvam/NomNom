//
//  FilterViewController.m
//  nomnom9.2
//
//  Created by Joanna Wang on 4/30/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize typeText;
@synthesize TypeEnable;
@synthesize oneDollar;
@synthesize twoDollar;
@synthesize threeDollar;
@synthesize fourDollar;
@synthesize distance;
@synthesize distanceValue;
@synthesize liked;


- (void)viewDidLoad {
    [super viewDidLoad];
    // set title colors for the buttons to show how many dollar signs to apply
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSMutableArray *prices = [[NSUserDefaults standardUserDefaults] objectForKey:@"prices"];
    self.distance.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"distance"];
    self.TypeEnable.on =[[NSUserDefaults standardUserDefaults] integerForKey:@"OneTypeSwitch"];
    self.typeText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"type"];
    self.oneDollar.selected = prices[0];
    self.twoDollar.selected = prices[1];
    self.threeDollar.selected = prices[2];
    self.fourDollar.selected = prices[3];
    [self.oneDollar setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.oneDollar setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.twoDollar setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.twoDollar setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.threeDollar setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.threeDollar setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.fourDollar setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.fourDollar setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    self.distanceValue.text = [NSString stringWithFormat:@"%.02f miles", self.distance.value/1600];
    // Do any additional setup after loading the view.
}
- (IBAction)distanceChange:(id)sender {
    self.distanceValue.text = [NSString stringWithFormat:@"%f miles", self.distance.value/1.6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)switchAction:(id)sender {
    if (self.TypeEnable.on == YES) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"OneTypeSwitch"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"type"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"OneTypeSwitch"];
        [[NSUserDefaults standardUserDefaults] setObject:self.typeText.text forKey:@"type"];
    }
}
- (IBAction)TypeAction:(id)sender {
    if (self.TypeEnable.on == YES) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"OneTypeSwitch"];
        [[NSUserDefaults standardUserDefaults] setObject:self.typeText.text forKey:@"type"];
    }
    else {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Type Filter not Enabled"
                                                                     message:@"Type Filter is not Enabled, do you want to enable it?"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Yes"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        self.TypeEnable.on = YES;
                                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"OneTypeSwitch"];
                                        [[NSUserDefaults standardUserDefaults] setObject:self.typeText.text forKey:@"type"];
                                        
                                    }];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"No"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                    }];
        [alert addAction:yesButton];
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}
- (IBAction)oneDollarAction:(id)sender {
    if (self.oneDollar.isSelected) {
        self.oneDollar.selected = NO;
    }
    else {
        self.oneDollar.selected = YES;
    }
}
- (IBAction)twoDollarsAction:(id)sender {
    if (self.twoDollar.isSelected) {
        self.twoDollar.selected = NO;
    }
    else {
        self.twoDollar.selected = YES;
    }
}
- (IBAction)threeDollarsAction:(id)sender {
    if (self.threeDollar.isSelected) {
        self.threeDollar.selected = NO;
    }
    else {
        self.threeDollar.selected = YES;
    }
}
- (IBAction)fourDollarAction:(id)sender {
    if (self.fourDollar.isSelected) {
        self.fourDollar.selected = NO;
    }
    else {
        self.fourDollar.selected = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"ApplyFilter"]) {
        NSMutableArray *prices = [@[@(self.oneDollar.selected), @(self.twoDollar.selected), @(self.threeDollar.selected), @(self.fourDollar.selected)] mutableCopy];
        [[NSUserDefaults standardUserDefaults] setInteger:self.distance.value forKey:@"distance"];
      [[NSUserDefaults standardUserDefaults] setObject:prices forKey:@"prices"];
        [[NSUserDefaults standardUserDefaults] setBool:self.TypeEnable.on forKey:@"OneTypeSwitch"];
        [[NSUserDefaults standardUserDefaults] setObject:self.typeText.text forKey:@"type"];
        
        NSLog(@"back to main segue done");
        ViewController *destViewController = segue.destinationViewController;
        destViewController.likedFood = self.liked;
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
