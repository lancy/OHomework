//
//  BackgroundLayer.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"

@interface BackgroundLayer(){
    CCSprite *_top0;
    CCSprite *_top1;
    CCSprite *_down0;
    CCSprite *_down1;
}

@end
@implementation BackgroundLayer

- (id)init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        // backgournd 0
        CCSprite *backgournd = [CCSprite spriteWithFile:@"background.png"];
        backgournd.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        [self addChild:backgournd z:0];
        
        // top
        _top0= [CCSprite spriteWithFile:@"pencil_up.png"];
        _top0.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        [self addChild:_top0 z:1];

        _top1= [CCSprite spriteWithFile:@"pencil_up.png"];
        _top1.position = CGPointMake(screenSize.width * 3 / 2, screenSize.height / 2);
        [self addChild:_top1 z:1];
        

        // top
        _down0= [CCSprite spriteWithFile:@"pencil_down.png"];
        _down0.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        [self addChild:_down0 z:1];
        
        _down1= [CCSprite spriteWithFile:@"pencil_down.png"];
        _down1.position = CGPointMake(screenSize.width * 3 / 2, screenSize.height / 2);
        [self addChild:_down1 z:1];

        
        [self scheduleUpdate];
	}
	return self;
}

- (void)update:(ccTime)delta
{
    [self moveSpriteLoop:_top0];
    [self moveSpriteLoop:_top1];
    [self moveSpriteLoop:_down0];
    [self moveSpriteLoop:_down1];

    
}

- (void)moveSpriteLoop:(CCSprite *)sprite
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    CGPoint position = sprite.position;
    if (position.x == -(screenSize.width / 2)) {
        position.x = screenSize.width * 3 / 2;
    }
    position.x -= 2;
    sprite.position = position;
}

@end
