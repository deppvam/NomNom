//
//  AccountViewController.m
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize emailLabel;
@synthesize resetPasswordField;
@synthesize confirmPasswordField;
@synthesize resetPasswordBtn;
@synthesize viewSavedRestaurantsBtn;
@synthesize signoutBtn;
@synthesize user;
@synthesize db;
@synthesize saved;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [FIRAuth auth].currentUser;
    self.emailLabel.text = self.user.email;
    
    if (user) {
        
        self.db = [FIRFirestore firestore];
        NSLog(@"%@", self.user.uid);
        NSString* uid = self.user.uid;
        FIRDocumentReference *docRef =
        [[self.db collectionWithPath:@"users"] documentWithPath:uid];
        self.saved = [[NSArray alloc ] init];
        [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
            if (snapshot.exists) {
                //NSLog(@"%@", NSStringFromClass([snapshot.data objectForKey:@"saved"]));
                if ([[snapshot.data objectForKey:@"saved"] count] != 0){
                    NSLog(@"%@",[snapshot.data objectForKey:@"saved"]);
                    self.saved = [snapshot.data objectForKey:@"saved"];
                    NSLog(@"in getting selfsaved= %@", self.saved);
                }
                else {
                    self.saved = [[NSMutableArray alloc] init];
                    
                }
            } else {
                NSLog(@"Document does not exist");
            }
        }];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetAction:(id)sender {
    
    if ([FIRAuth auth].currentUser) {
        if (self.resetPasswordField.text && self.confirmPasswordField.text) {
            if ([self.resetPasswordField.text isEqualToString:self.confirmPasswordField.text]) {
                [[FIRAuth auth].currentUser updatePassword:self.resetPasswordField.text completion:^(NSError *_Nullable error) {
                    // ...
                }];
            }
            else {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Unatching Password"
                                                                             message:@"new password and confirm do not match, try again!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action)
                                            {
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }];
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
    }
}
- (IBAction)viewSavedAction:(id)sender {
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
                NSLog(@"local saved %@", self.saved);
                
            } else {
                NSLog(@"Document does not exist");
            }
        }];
        [self performSegueWithIdentifier:@"savedSegue" sender:nil];
    }
    
    
}
- (IBAction)signOutAction:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    else {
        [self performSegueWithIdentifier:@"signoutSegue" sender:nil];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"savedSegue"]) {
        UserRestaurantsView *destViewController = segue.destinationViewController;
        destViewController.saved = self.saved;
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

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

@end
