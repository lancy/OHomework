//
//  GameLayer.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "GameLayer.h"
#import "BackgroundLayer.h"
#import "Player.h"
#import "Block.h"

@interface GameLayer() {
    
}

@property (nonatomic, strong) Player* player;
@property (nonatomic, strong) CCArray *blockArray;
@property BOOL isFalling;
@property CGFloat speed;

@end

@implementation GameLayer

+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
- (id)init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		CCLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer];
        
        
        self.player = [Player node];
        [self addChild:self.player];
        
        self.blockArray = [CCArray array];        
        
        [self setIsFalling:YES];
        [self setSpeed:0];
        
        [self scheduleUpdate];
        [self setIsTouchEnabled:YES];
	}
	return self;
}

- (void)update:(ccTime)delta
{
    [self schedule:@selector(createRandomBlock) interval:3];
    [self updatePlayerPosition];
    [self updateBlockPosition];
}


- (void)updateBlockPosition
{
    for (Block *block in self.blockArray) {
        CGPoint position = block.position;
        position.x -= 1;
        block.position = position;
        
        if (position.x < -50) {
            [self.blockArray removeObject:block];
            [block removeFromParentAndCleanup:YES];
        }
    }
}

- (void)updatePlayerPosition
{
    CGPoint position = self.player.position;
    if ([self isFalling]) {
        self.speed -= 0.05;
    } else {
        self.speed += 0.05;
    }
    position.y += self.speed;
    self.player.position = position;
}

- (void)createRandomBlock
{
    Block *block = [Block node];
    [self.blockArray addObject:block];
    block.position = [self randomPositionOutsiteWindows];
    [self addChild:block];
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setSpeed:0.1];
    [self setIsFalling:NO];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setSpeed:0.1];
    [self setIsFalling:YES];
}


- (CGPoint)randomPositionOutsiteWindows
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint position = CGPointMake(winSize.width, CCRANDOM_0_1() * winSize.height);
    return position;
}



@end
