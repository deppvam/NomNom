//
//  ListViewController.h
//  nomnom9.2
//
//  Created by nyuguest on 4/25/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "ViewController.h"

@interface ListViewController : ViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *liked;
@end
