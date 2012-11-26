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
#import "CCAnimation+Helper.h"
#import "AVMicInput.h"

#define SCORE_LABEL_TAG 15
#define HIGH_LABEL_TAG 16

@interface GameLayer() {
    
}

@property (nonatomic, strong) Player* player;
@property (nonatomic, strong) CCArray *blockArray;
@property (nonatomic, strong) AVMicInput *micInput;
@property BOOL isFalling;
@property CGFloat speed;
@property NSInteger score;
@property NSInteger highScore;

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
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // init background layer
		CCLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer];
        
        // init player
        self.player = [Player node];
        [self addChild:self.player];
        [self startAnimation];
        
        
        // init label
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Marker Felt" fontSize:32];
        [self addChild:label z:1 tag:SCORE_LABEL_TAG];
        
        CCLabelTTF *highLabel = [CCLabelTTF labelWithString:@"High Score: 0" fontName:@"Marker Felt" fontSize:32];
        [self addChild:highLabel z:1 tag:HIGH_LABEL_TAG];
        
        
        self.micInput = [[AVMicInput alloc] init];
        
        self.blockArray = [CCArray array];
        
        [self setIsFalling:YES];
        [self setSpeed:0];
        
        [self scheduleUpdate];
        [self setIsTouchEnabled:YES];
        
        [self initGame];
	}
	return self;
}

- (void)update:(ccTime)delta
{
    [self schedule:@selector(createRandomBlock) interval:1];
    [self updatePlayerPosition];
    [self updateBlockPosition]; 
    [self checkForCollision];
    [self schedule:@selector(updateScore) interval:1];
    [self updateMicInput];
}

- (void)updateMicInput
{
    float micIn = [self.micInput micAveragePower];
    if (micIn > -20 && self.isFalling) {
        self.isFalling = NO;
        self.speed = 0.1;
    };
    if (micIn < -20 && !self.isFalling) {
        self.isFalling = YES;
        self.speed = 0.1;
    }
    CCLOG(@"mic input = %f", micIn);
}

- (void)updateScore
{
    self.score += 1;
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:SCORE_LABEL_TAG];
    [label setString:[NSString stringWithFormat:@"Score: %d", self.score]];
    
    if (self.score > self.highScore) {
        self.highScore = self.score;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.highScore] forKey:@"highScore"];
        CCLabelTTF *highLabel = (CCLabelTTF *)[self getChildByTag:HIGH_LABEL_TAG];
        [highLabel setString:[NSString stringWithFormat:@"High Score: %d", self.highScore]];
    }
    
}

- (void)checkForCollision
{
    for (Block *block in self.blockArray) {
        float distance = ccpDistance(self.player.position, block.position);
        if (distance < 50) {
            [self gameOver];
        }
    }
}


- (void)updateBlockPosition
{
    for (Block *block in self.blockArray) {
        CGPoint position = block.position;
        position.x -= 2;
        block.position = position;
        
        if (position.x < -50) {
            [self.blockArray removeObject:block];
            [block removeFromParentAndCleanup:YES];
        }
    }
}

- (void)updatePlayerPosition
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint position = self.player.position;
    if ([self isFalling]) {
        self.speed -= 0.05;
        if (position.y < 25) {
            self.speed = 0;
            [self gameOver];
        }

    } else {
        self.speed += 0.05;
        if (position.y > winSize.height - 25) {
            self.speed = 0;
            [self gameOver];
        }

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
    if (![[CCDirector sharedDirector] isAnimating]) {
        [self initGame];
        [[CCDirector sharedDirector] startAnimation];

    }
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

- (void)startAnimation
{
    CCAnimation *animation = [CCAnimation animationWithFile:@"circle" frameCount:3 delay:0.25];
    CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
    [self.player runAction:repeat];
}

- (void)gameOver
{
    [[CCDirector sharedDirector] stopAnimation];
    [self changeScoreLabel];
    [self changeHighLabel];
}

- (void)initGame
{
    for (Block* block in self.blockArray) {
        [block removeFromParentAndCleanup:YES];
    }
    [self.blockArray removeAllObjects];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    self.player.position = CGPointMake(50, winSize.height - 100);
    
    self.highScore = [[[NSUserDefaults standardUserDefaults] valueForKey:@"highScore"] intValue];    
    CCLabelTTF *highLabel = (CCLabelTTF *)[self getChildByTag:HIGH_LABEL_TAG];
    [highLabel setString:[NSString stringWithFormat:@"High Score: %d", self.highScore]];

    self.score = 0;
    
    [self changeScoreLabel];
    [self changeHighLabel];
}

- (void)changeScoreLabel
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:SCORE_LABEL_TAG];
    
    if (self.score == 0) {
        label.position = ccp(winSize.width, winSize.height);
        label.anchorPoint = ccp(1.0, 1.0);
        label.fontSize = 32;

    } else {
        label.position  = ccp(winSize.width / 2, winSize.height / 2);
        label.anchorPoint = ccp(0.5, 0.5);
        label.fontSize = 64;
    }
}

- (void)changeHighLabel
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:HIGH_LABEL_TAG];
    
    if (self.score == 0) {
        label.position = ccp(0, winSize.height);
        label.anchorPoint = ccp(0, 1.0);
        label.fontSize = 32;
        
    } else {
        label.position  = ccp(winSize.width / 2, winSize.height / 2 - 40);
        label.anchorPoint = ccp(0.5, 0.5);
    }    
}


@end
