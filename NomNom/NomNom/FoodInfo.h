//
//  FoodInfo.h
//  NomNom
//
//  Created by Joanna Wang on 4/20/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpRequest.h"
#include <stdlib.h>
#import <UIKit/UIKit.h>

@interface FoodInfo : NSObject
@property(nonatomic) NSString *Description, *FoodName;
@property(nonatomic) UIImage *Image;
-(void) set_Obj: (NSString *)s : (NSString *)foodName: (UIImage *)image;
@end
