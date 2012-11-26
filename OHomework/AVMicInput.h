//
//  AVMicInput.h
//  OHomework
//
//  Created by Lancy on 23/11/12.
//
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface AVMicInput : NSObject {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
}

- (float)micAveragePower;
- (void)stopRecord;

@end