//
//  ThirdViewController.m
//  NomNom
//
//  Created by TIMGO001 on 4/24/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (IBAction)Logout:(id)sender {
    // when log out, user should go back to 2nd view controller
    UIViewController *controler = [[UIViewController alloc] init];
    [self.navigationController pushViewController:controler animated:YES];

    
}


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil];
    if(self){
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // show data 
    self.ref = [[FIRDatabase database] reference];
    
        // ...
  
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

- (IBAction)logout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
