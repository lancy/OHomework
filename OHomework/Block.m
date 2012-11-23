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
        self = [CCSprite spriteWithFile:@"player.png"];
	}
	return self;
}


@end
