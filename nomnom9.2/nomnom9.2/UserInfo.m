//
//  UserInfo.m
//  nomnom9.2
//
//  Created by Joanna Wang on 4/29/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize uid;
@synthesize email;
@synthesize saved;

-(instancetype) initWithAttributes :(NSString*) userid: (NSString*)em:(NSMutableArray*) save {
    self = [super init];
    if (self) {
        self.uid = userid;
        self.email = em;
        self.saved = save;
    }
    
    return self;
    
}
@end
