//
//  AVMicInput.m
//  OHomework
//
//  Created by Lancy on 23/11/12.
//
//

#import "AVMicInput.h"
@implementation AVMicInput
-(id) init
{
    if( (self=[super init]) ) {
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityMin],         AVEncoderAudioQualityKey,
                                  nil];
        NSError *error;
        
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
        if (recorder) {
            [recorder prepareToRecord];
            recorder.meteringEnabled = YES;
            [recorder record];
        } else
            NSLog(@"%@",[error description]);
    }
    return self;
}

-(float) micAveragePower
{
    [recorder updateMeters];
    float avgPower = [recorder averagePowerForChannel:0];
    //NSLog(@"%f",avgPower);
    return avgPower;
}

- (void)stopRecord
{
    [recorder stop];
}

@end