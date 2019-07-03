//
//  DVMCardController.h
//  DeckObjc
//
//  Created by Julia Rodriguez on 7/2/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCard.h"
#import <UIKit/UIKit.h>
@class DVMCard;

NS_ASSUME_NONNULL_BEGIN

@interface DVMCardController : NSObject

+(DVMCardController *)sharedInstance;

+(void)drawNewCard:(void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;
+(void)fetchImage:(DVMCard *)card completion: (void(^) (UIImage *image, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END

