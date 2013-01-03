//
//  Player.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "CCAnimation+Helper.h"



@implementation Player

- (id)init
{
    if((self=[super init])) {
        self = [CCSprite spriteWithFile:@"people_0.png"];        
	}
	return self;
}



@end
