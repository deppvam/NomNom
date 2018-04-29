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
    
    NSString *ratings =[self.resto objectForKey:@"rating"];
    
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
    
    //set detail box : detail_object
    NSMutableAttributedString *details = [[NSMutableAttributedString alloc] initWithString:@"Price:\t\t"];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[self.resto objectForKey:@"price"]]];

    //Price above ^
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\nPhone:\t\t"]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[self.resto objectForKey:@"display_phone"]]];
    //Phone Number above^
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\nAddress:\t\t"]];
    
    NSDictionary *location = [self.resto objectForKey:@"location"];
    
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"address1"]]];
    if([[location objectForKey:@"address2"] length] != 0 ){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\t\t"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"address2"]]];
    }
    if([[location objectForKey:@"address3"] length] != 0 ){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\t\t"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"address3"]]];
    }
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\t\t"]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"city"]]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"state"]]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"zip_code"]]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"country"]]];

    if([[location objectForKey:@"cross_streets"] length] != 0 ){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\nCross Streets:\t\t"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"cross_streets"]]];
    }
    //Address above^
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\nCategories:\t\t"]];
    for(id object in [self.resto objectForKey:@"categories"]){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[object objectForKey:@"title"]]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    }
    //Categories above ^
    NSMutableString * transction = [[NSMutableString alloc] init];
    for(id object in [self.resto objectForKey:@"transactions"]){
        if( [object isEqualToString:@"pickup"])
        {
            [transction appendString:@"Order Pickup"];
            [transction appendString:@","];
        }
        if( [object isEqualToString:@"delivery"])
        {
            [transction appendString:@"Order Delivery"];
            [transction appendString:@","];
        }
        if( [object isEqualToString:@"restaurant_reservation"])
        {
            [transction appendString:@"Reservations"];
            [transction appendString:@","];
        }
    }
    if([transction length] != 0)
    {
        transction = [[NSMutableString alloc] initWithString:[@"Categories" stringByAppendingString:transction]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\nAccepts:\t\t"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:transction]];
    }
    //Transactions ^
    self.detail_object.text = [details string];
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
