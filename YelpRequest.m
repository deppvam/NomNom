//
//  YelpRequest.m
//  LocationTester
//
//  Created by nyuguest on 4/16/18.
//  Copyright © 2018 nyuguest. All rights reserved.
//

#import "YelpRequest.h"

@implementation YelpRequest


/*  makes an API request
 *  arguments
 *      latitutde   - NSString              probably taken from gps services
 *      longitude   - NSString              probably taken from gps services
 *      rad         - int                   from user-defined parameters; radius to be searches in METERS
 *      lim         - int                   should be 50; how many restaurants to get with the request
 *  returns
 *      newDict     - NSMutableDictionary   returns an NSMutableDictionary where the keys are yelp business IDs and the objects are NSDictionaries representing the bussiness
 *                                              Structure of the (inner) yelp business dictionary:
 *                                                  key                 type                description of yelp business key
 *                                                  id                  NSString            Unique Yelp Id
 *                                                  is_closed           __NSCFBoolean       Is this business closed right now?
 *                                                  review_count        NSNumber            Number of reviews for this business
 *                                                  categories          NSArray             Each index is an NSDictionary with keys "alias" and "title"
 *                                                  rating              NSNumber            rating for this restaurant (1,2,...,4.5,5)
 *                                                  phone               NSString            unformatted phone number of restaurant
 *                                                  image_url           NSString            url of the restaurant's main photo
 *                                                  url                 NSString            url of the yelp page
 *                                                  display_phone       NSString            Nicely formatted phone number.
 *                                                  price               NSString            how many dollar signs it is
 *                                                  location            NSDictionary        the location of the restaurant
 *                                                                                              keys: address1, address2,   address3,   city,   state,  zip_code,   country,    display_address,    cross_streets
 *                                                                                              types:NSString  NSString    NSString    NSStringNSStringNSString    NSString    NSArray             NSString
 *                                                                                                                                                                              ex:["800 N Point St","San Fransisco, CA 94109"]
 *                                                  alias               NSString
 *                                                  coordinates         NSDictionary        The GPS coordinates of the restaurant. keys: latitude,longitude ; values are doubles.
 *                                                  transactions        NSArray             Array of Strings of Yelp transactions the business is registered for: possible entries: "pickup" "delivery" "restaurant_reservation"
 *                                                  distance            NSNumber            Distance from our GPS location
 *                                                  name                NSString            full title of restaurant
 */
+ (NSDictionary*)makeYelpRequest:(NSString*)latitude
                            long:(NSString*)longitude
                          radius:(int)rad
                           limit:(int)lim
                          offset:(int)off{
    NSString *api_key = @"gH5KZskN3SWdOpqY_Ft9UtjhqyVlIsTu2qFzGN0k0_wlSP4LpN1_3a6j1vVYMhI-TAYaCk-PXt48S4WAPLsQ7IhOjmKByXtAvSEwhv0b9dbfLaNb6_sJi1dr-tzLWnYx"; // probably need to store this in firebase? maybe?
    
    //Set up our URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    NSString *url = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?location=%@,%@&radius=$d&limit=%d&offset=%d",latitude,longitude,rad,lim]; //change this to change the site we're pinging
    NSString *header = [NSString stringWithFormat:@"Bearer %@",api_key];
    [request setURL:[NSURL URLWithString:url]];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    //Make the request and save the JSON data we get
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; // Yes, this is deprecated. But it works for now as i try to get something workable
    
    
    NSDictionary *responseObj = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:0
                                 error:&error]; //a JSON dictionary of our stuff!!!
    
    
    NSArray *businesses = [responseObj objectForKey:@"businesses"]; //extract the businsses array from the JSON dictionary
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init]; //initialize the dictionary
    for(id obj in businesses){
        if(newDict[[obj objectForKey:@"id"]]==nil)
            newDict[[obj objectForKey:@"id"]] = obj;
    }
    return newDict;
}
@end
