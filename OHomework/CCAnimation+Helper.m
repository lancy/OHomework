//
//  CCAnimation+Helper.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//
//

#import "CCAnimation+Helper.h"

@implementation CCAnimation (Helper)

+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount
                            delay:(float)delay
{
    // 把动画帧作为贴图进行加载,然后生成精灵动画帧
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i = 0; i < frameCount; i++) {
        // 假设所有动画帧文件的名字是”nameX.png”
        NSString* file = [NSString stringWithFormat:@"%@%i.png", name, i];
        CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
        // 假设总是使用整个动画帧文件
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTextureFilename:file rect:texRect];
        
        [frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end
