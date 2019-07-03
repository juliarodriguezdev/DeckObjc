//
//  DVMCard.m
//  DeckObjc
//
//  Created by Julia Rodriguez on 7/2/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

- (instancetype)initWithCard:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self) {
        _suit = suit;
        _image = image;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    
    NSString *suit = dictionary[@"suit"];
    NSString *image = dictionary[@"image"];
    
    return [self initWithCard:suit image:image];
    
    
}
@end
