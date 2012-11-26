//
//  Block.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Block.h"


@implementation Block

- (id)init
{
    if((self=[super init])) {
        NSInteger index = round(CCRANDOM_0_1() * 2);
        self = [CCSprite spriteWithFile:[NSString stringWithFormat:@"circle%d.png", index]];
	}
	return self;
}


@end
