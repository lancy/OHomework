//
//  CCAnimation+Helper.h
//  OHomework
//
//  Created by Lancy on 23/11/12.
//
//

#import "CCAnimation.h"
#import "cocos2d.h"

@interface CCAnimation (Helper)

+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount
                            delay:(float)delay;

@end
