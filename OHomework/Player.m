//
//  Player.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

- (id)init
{
    if((self=[super init])) {
        self = [CCSprite spriteWithFile:@"player.png"];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.position = CGPointMake(50, winSize.height - 100);
        
	}
	return self;
}


@end
