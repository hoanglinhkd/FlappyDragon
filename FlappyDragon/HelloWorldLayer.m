//
//  HelloWorldLayer.m
//  FlappyDragon
//
//  Created by Linh Nguyen on 2/16/14.
//  Copyright Linh Nguyen 2014. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

@interface HelloWorldLayer(){
    NSMutableArray *arrFrameNameBird;
    NSTimer *timeRunGlobalAction;
    BOOL isStarted;
}

@end
// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        //init status of scenes
        [self setTouchEnabled:YES];
        
        // init frame resource center
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"resource1.plist"];
        
        // the major background
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"bg.png"];
        bg.anchorPoint = ccp(0, 0);
        bg.scale = 2.22222*2;
        [self addChild:bg z:-1];
        
        // our bird
		CCSprite *bird = [CCSprite spriteWithSpriteFrameName:@"bird1.png"];
        bird.scale = 2.22222*2;
        CGSize size = [[CCDirector sharedDirector] winSize];
        bird.position = ccp(size.width/2, size.height/2);
        [self addChild:bird];
        bird.tag = 1;
        
        //init NameFrame For Bird
        arrFrameNameBird = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i=1; i<=3; i++) {
            NSString *nameFrame = [NSString stringWithFormat:@"bird%d.png",i];
            CCSpriteFrame *spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nameFrame];
            spriteFrame.rotated = YES;
            [arrFrameNameBird addObject:spriteFrame];
        }
        /*
		timeRunGlobalAction = [NSTimer timerWithTimeInterval:1.0f/24.0f target:self selector:@selector(runDefaultAction) userInfo:nil repeats:YES];
        [timeRunGlobalAction fire];
         */
        //bird runAction:<#(CCAction *)#>
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

#pragma mark - Touch Delegate
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isStarted==NO) {
        [self runDefaultAction];
        isStarted = YES;
    }
    //get bird from self
    CCSprite *bird = (CCSprite*)[self getChildByTag:1];
    bird.rotationX = 5;
    
    //CCAnimation *a = [CCAnimation animationWithSpriteFrames:arrFrameNameBird delay:1.0f/24.0f];
    //[bird runAction:[CCAnimate actionWithAnimation:a]];
    [bird runAction:[CCMoveBy actionWithDuration:0.2f position:ccp(0, 100)]];
    
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    /*
    CCSprite *bird = (CCSprite*)[self getChildByTag:1];
    CCAnimation *a = [CCAnimation animationWithSpriteFrames:arrFrameNameBird delay:1.0f/24.0f];
    [bird runAction:[CCAnimate actionWithAnimation:a]];
    [bird runAction:[CCMoveBy actionWithDuration:0.25 position:ccp(0,-5)]];
     */
    //[self runDefaultAction];
}

#pragma mark - Run Action
/*
- (void) runDefaultAction{
    CCSprite *bird = (CCSprite*)[self getChildByTag:1];
    CCAnimation *a = [CCAnimation animationWithSpriteFrames:arrFrameNameBird delay:1.0f/24.0f];
    [bird runAction:[CCAnimate actionWithAnimation:a]];
    [bird runAction:[CCSequence actions:[CCMoveBy actionWithDuration:3.0f/24.0f position:ccp(0,-10)],
                                        [CCCallFunc actionWithTarget:self selector:@selector(runDefaultAction)],nil]];
}
 */
- (void) runDefaultAction{
    CCSprite *bird = (CCSprite*)[self getChildByTag:1];
    CCAnimation *a = [CCAnimation animationWithSpriteFrames:arrFrameNameBird delay:1.0f/24.0f];
    //[bird runAction:[CCAnimate actionWithAnimation:a]];
    //[bird runAction:[CCMoveBy actionWithDuration:3.0f/24.0f position:ccp(0,-10)]];
    CCRepeatForever *action = [CCRepeatForever actionWithAction:
                               [CCAnimate actionWithAnimation:a]];
    [bird runAction:action];
    bird.flipX = YES;
    //CCRepeatForever *actionFall = [Utils getCCRepeatForeverFallDown];
    //[bird runAction:actionFall];
    bird.rotationX = 2;
    bird.rotationY = 4;
}


@end
