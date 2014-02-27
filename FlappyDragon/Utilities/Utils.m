//
//  Utils.m
//  FlappyDragon
//
//  Created by Linh.Nguyen on 2/26/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (CCRepeatForever*) getCCRepeatForeverFallDown{
    CCRepeatForever *ccrepeat = [CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:1.0f/24.0f position:ccp(0,-10)]];
    return ccrepeat;
}

@end
