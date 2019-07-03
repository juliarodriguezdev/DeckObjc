//
//  DVMCardController.m
//  DeckObjc
//
//  Created by Julia Rodriguez on 7/2/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

#import "DVMCardController.h"
#import "DVMCard.h"

static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw/";

@implementation DVMCardController

+(DVMCardController *)sharedController
{
    static DVMCardController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [DVMCardController new];
    });
    return sharedController;
}

+ (void)drawNewCard:(void (^)(NSArray<DVMCard *> * _Nullable, NSError * _Nullable))completion
{
    // https://deckofcardsapi.com/api/deck/new/draw/?count=1
    // End result of url
    
    // step 1 - create base url
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *count = [NSURLQueryItem queryItemWithName:@"count" value:@"1"];
    
    components.queryItems = @[count];
    
    NSURL *finalURL = components.URL;
    
    NSLog(@"%@", finalURL);
    
    // Step 2 - Start with the dataTask
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // if there is an error
        if (error) {
            NSLog(@"There is an error %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        // Check the response
        if (response)
        {
            NSLog(@"%@", response);
        }
        // Get the data
        if (data)
        {
            // 2 = allow fragments, &error = same NSError for everything
            NSDictionary *JSONdictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            
            if (!JSONdictionary)
            {
                NSLog(@"Error parsing the JSON: %@", error);
                completion(nil, error);
                return;
            }
            // If we made it here, have successfully parsed my JSON and should be able to complete with a Card Object
            
            // create an array
            
            NSArray *cardsArray = JSONdictionary[@"cards"];
            // empty array new = alloc init
            NSMutableArray *cardsPlaceHolderArray = [NSMutableArray new];
            
            // create placeholder
            // for (dictinary in cardsArray)
            for (id dictionary in cardsArray)
            {
                // for in loop
                // type nameOfObject
                DVMCard *newCard = [[DVMCard alloc] initWithDictionary:dictionary];
                // append new card to array
                [cardsPlaceHolderArray addObject:newCard];
            }
            
            //complete with an array of cards or nil
            completion(cardsPlaceHolderArray, nil);
        }
    }] resume];
    
}

+ (void)fetchImage:(DVMCard *)card completion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completion
{
    NSURL *cardImageURL = [NSURL URLWithString:card.image];
    // let cardImageURL: URL = URL(string: "")
    
    [[[NSURLSession sharedSession] dataTaskWithURL:cardImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // if there is an error
        if (error) {
            NSLog(@"There is an error %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        if (data) {
            UIImage *cardImage = [UIImage imageWithData: data];
            completion(cardImage, error);
        }
        
    }] resume];
    
    
}

@end
