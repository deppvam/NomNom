//
//  RestaurantViewController.m
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "RestaurantViewController.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController
@synthesize resto;
@synthesize navBar;
@synthesize image_url;
@synthesize detail_object;
@synthesize rating;
@synthesize restoName;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.navBar.=[self.resto objectForKey:@"name"];
    // Do any additional setup after loading the view.
    
    //Restaurant Name
    self.restoName.text = [self.resto objectForKey:@"name"];
    self.restoName.textColor = [UIColor whiteColor];
    //Rating
    //Begin Appending Yelp Branding... for ratings
    NSMutableAttributedString *description = [[NSMutableAttributedString alloc] init];
    [description appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@""]];
    //NSMutableAttributedString *description = [[NSMutableAttributedString alloc] initWithString:@"\nYelp Rating: \t\t"];
    
    NSString *ratings =[resto objectForKey:@"rating"];
    
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
    imageAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",ratings]];

    CGFloat imageOffsetY = -5.0;
    imageAttachment.bounds = CGRectMake(0, imageOffsetY, imageAttachment.image.size.width, imageAttachment.image.size.height);
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [description appendAttributedString:attachmentString];
    [description appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\nBased on %@ reviews",[self.resto objectForKey:@"review_count"]]]];
    rating.attributedText=description;
    rating.textColor = [UIColor whiteColor];
    //End Yelp Branding
    
    
    //Image
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.resto objectForKey:@"image_url"]]];
    NSLog([[self.resto objectForKey:@"image_url"] description]);
    [self.image_url setImage:[UIImage imageWithData: imageData]];
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

@end
