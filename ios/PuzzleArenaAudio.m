#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(PuzzleArenaAudio, NSObject)

RCT_EXTERN_METHOD(playBackground:(NSString *)name
                  loop:(BOOL)loop
                  volume:(nonnull NSNumber *)volume
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(stopBackground:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(playEffect:(NSString *)name
                  volume:(nonnull NSNumber *)volume
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
