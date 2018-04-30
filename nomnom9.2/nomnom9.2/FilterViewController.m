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
@synthesize minlabel;
@synthesize maxlabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"minPrice"];
//[[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"maxPrice"];
//[[NSUserDefaults standardUserDefaults] setInteger:8000 forKey:@"distance"];//5miles?
- (IBAction)setMinOne:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"minPrice"];
    self.minlabel.text=@"Min: $";
}
- (IBAction)setMinTwo:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"minPrice"];
    self.minlabel.text=@"Min: $$";
}
- (IBAction)setMinThree:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"minPrice"];
    self.minlabel.text=@"Min: $$$";
}
- (IBAction)setMinFour:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"minPrice"];
    self.minlabel.text=@"Min: $$$$";
}
- (IBAction)setMinFive:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"minPrice"];
    self.minlabel.text=@"Min: $$$$$";
}

- (IBAction)setMaxOne:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"maxPrice"];
    self.maxlabel.text=@"Min: $";
}
- (IBAction)setMaxTwo:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"maxPrice"];
    self.maxlabel.text=@"Min: $$";
}
- (IBAction)setMaxThree:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"maxPrice"];
    self.maxlabel.text=@"Min: $$$";
}
- (IBAction)setMaxFour:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"maxPrice"];
    self.maxlabel.text=@"Min: $$$$";
}
- (IBAction)setMaxFive:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"maxPrice"];
    self.maxlabel.text=@"Min: $$$$$";
}
- (IBAction)distanceSlider:(id)sender{
    //???
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
