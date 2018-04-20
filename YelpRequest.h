//
//  YelpRequest.h
//  LocationTester
//
//  Created by nyuguest on 4/16/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface YelpRequest : NSObject
+(NSDictionary*)makeYelpRequest:(NSString*)latitude long:(NSString*)longitude radius:(int)rad limit:(int)lim offset:(int)off;
@end


