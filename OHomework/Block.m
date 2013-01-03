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
        NSInteger index = round(CCRANDOM_0_1() * 3);
        self = [CCSprite spriteWithFile:[NSString stringWithFormat:@"sth_%d.png", index]];
	}
	return self;
}


@end
