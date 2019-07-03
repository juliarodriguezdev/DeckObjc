//
//  DVMCard.h
//  DeckObjc
//
//  Created by Julia Rodriguez on 7/2/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *image;


-(instancetype)initWithCard:(NSString *)suit
                      image:(NSString *)image;

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

@interface DVMCard (JSONConvertable)

@end

NS_ASSUME_NONNULL_END
