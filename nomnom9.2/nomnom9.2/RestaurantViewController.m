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
@synthesize backBtn;
@synthesize saveBtn;
@synthesize segueIden;
@synthesize liked;
@synthesize saved;
@synthesize db;
@synthesize user;
@synthesize localUser;
@synthesize ref;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.segueIden isEqualToString:@"fromSaved"]) {
        [self.saveBtn setAccessibilityElementsHidden:YES];
    }
    self.user = [FIRAuth auth].currentUser;
    if (user) {
        NSLog(@"before firestore");
        self.db = [FIRFirestore firestore];
        self.ref = [[self.db collectionWithPath:@"users"] documentWithPath:user.uid];
    }
    

   
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
    self.rating.attributedText=description;
    self.rating.textColor = [UIColor whiteColor];
    //End Yelp Branding
    
    
    //Image
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.resto objectForKey:@"image_url"]]];
    NSLog([[self.resto objectForKey:@"image_url"] description]);
    [self.image_url setImage:[UIImage imageWithData: imageData]];
    
    //set detail box : detail_object
    NSMutableAttributedString *details = [[NSMutableAttributedString alloc] init];
    
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[self.resto objectForKey:@"price"]]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" · "]];
    //Price above ^
    for(id object in [self.resto objectForKey:@"categories"]){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[object objectForKey:@"title"]]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    }
    //Categories above ^
    // address image here [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\nAddress:\t\t"]];
    
    NSDictionary *location = [self.resto objectForKey:@"location"];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"address1"]]];
    if([location objectForKey:@"address2"]!=nil && [[location objectForKey:@"address2"] length] != 0 ){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"address2"]]];
    }
    if([location objectForKey:@"address3"]!=nil && [[location objectForKey:@"address3"] length] != 0 ){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"address3"]]];
    }
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"city"]]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"state"]]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"zip_code"]]];
    //[details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@","]];
    //[details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"country"]]];
    
    if([location objectForKey:@"cross_streets"]!=nil && [[location objectForKey:@"cross_streets"] length] != 0 ){
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n b/t "]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[location objectForKey:@"cross_streets"]]];
    }
    //Address above^
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[self.resto objectForKey:@"display_phone"]]];
    //Phone Number above^
    
    /*
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
    if(transction!=nil && [transction length] != 0)
    {
        transction = [[NSMutableString alloc] initWithString:[@"Categories" stringByAppendingString:transction]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\nAccepts:"]];
        [details appendAttributedString:[[NSMutableAttributedString alloc] initWithString:transction]];
    }
     */
    //Transactions ^

    self.detail_object.attributedText=details;
    self.detail_object.textColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtnAction:(id)sender {
    self.user = [FIRAuth auth].currentUser;
   
    if (user) {
        
        self.db = [FIRFirestore firestore];
        NSLog(@"%@", self.user.uid);
        NSString* uid = self.user.uid;
        FIRDocumentReference *docRef =
        [[self.db collectionWithPath:@"users"] documentWithPath:uid];
        [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
            if (snapshot.exists) {
                NSLog(@"Document data: %@", snapshot.data);
                NSLog(@"Document data: %@", [snapshot.data objectForKey:@"saved"]);
                if ([[snapshot.data objectForKey:@"saved"] count] != 0){
                    self.saved = [[snapshot.data objectForKey:@"saved"] mutableCopy];
                    NSLog(@"in getting selfsaved= %@", self.saved);
                }
                else {
                    self.saved = [[NSMutableArray alloc] init];
                    
                }
                [self.saved addObject: [self.resto objectForKey:@"id"]];
                NSLog(@"local saved %@", self.saved);
                [[[self.db collectionWithPath:@"users"] documentWithPath:uid]
                 setData:@{ @"saved": self.saved}
                 options:[FIRSetOptions merge]
                 completion:^(NSError * _Nullable error) {
                     
                     UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Success"
                                                                                  message:@"NomNom has successfully saved data"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"OK"
                                                                         style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action)
                                                 {
                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                 }];
                     [alert addAction:yesButton];
                     [self presentViewController:alert animated:YES completion:nil];
                     // ...
                 }];
            } else {
                NSLog(@"Document does not exist");
            }
        }];
       
        
        
        
         
         
        
       
        
    }
}
- (IBAction)backBtnAction:(id)sender {
    if ([self.segueIden isEqualToString:@"cellToRestaurantSegue"]){
        
        [self performSegueWithIdentifier:@"backToLiked" sender:nil];
        
    }
    else if ([self.segueIden isEqualToString:@"fromSaved"]) {
        [self performSegueWithIdentifier:@"backToSaved" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backToLiked"]) {
        ListViewController *destViewController = segue.destinationViewController;
        destViewController.liked = self.liked;
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

- (IBAction)sentToYelp:(id)sender {
    NSURL *url = [ [ NSURL alloc ] initWithString:[self.resto objectForKey:@"url"]];
    
    [[UIApplication sharedApplication] openURL:url];
}
@end
