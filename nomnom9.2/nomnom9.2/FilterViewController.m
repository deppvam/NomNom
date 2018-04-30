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
@synthesize filters;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.filters = [[NSDictionary alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)switchAction:(id)sender {
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
