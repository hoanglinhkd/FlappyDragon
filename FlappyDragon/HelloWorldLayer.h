//
//  HelloWorldLayer.h
//  FlappyDragon
//
//  Created by Linh Nguyen on 2/16/14.
//  Copyright Linh Nguyen 2014. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "Utils.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
