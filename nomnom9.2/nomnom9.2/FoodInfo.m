//
//  FoodInfo.m
//  NomNom
//
//  Created by Joanna Wang on 4/20/18.
//  Copyright © 2018 Joanna Wang. All rights reserved.
//

#import "FoodInfo.h"

@implementation FoodInfo
@synthesize Description, FoodName, Image;
-(void) set_Obj: (NSString *)desc name:(NSString *)foodName imageURL:(UIImage *)image{
    FoodName = foodName;
    Description = desc;
    Image = image;
}
@end
