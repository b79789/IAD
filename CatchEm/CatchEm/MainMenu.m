//
//  MainMenu.m
//  CatchEm
//
//  Created by Brian Stacks on 8/26/15.
//  Copyright (c) 2015 Brian Stacks. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"
#import "cutScene1.h"
#import <GameKit/GameKit.h>
@import GameKit;

@implementation MainMenu



-(id)initWithSize:(CGSize)size{
    
    
    
    
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        SKSpriteNode *menu = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenu.png"];
        menu.size =CGSizeMake(screenWidth, screenHeight);
        menu.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        menu.name = @"MainMenu";
        [self addChild:menu];
        
        SKSpriteNode *start = [SKSpriteNode spriteNodeWithImageNamed:@"startButton.png"];
        start.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)- 25);
        start.name = @"Start";
        start.zPosition=5;
        [self addChild:start];
        
        SKSpriteNode *leaderButton = [SKSpriteNode spriteNodeWithImageNamed:@"leaderButton.png"];
        leaderButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)- 225);
        leaderButton.zPosition=4;
        leaderButton.name = @"leaderBoardButton";
        [self addChild:leaderButton];
        
        [self authenticateLocalPlayer];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"Start"]) {
        
        GKAchievement *achievement =
        [[GKAchievement alloc] initWithIdentifier: @"startAchievement"];
        achievement.showsCompletionBanner = YES;
        achievement.percentComplete = 100;
        NSArray *achievementsToComplete = [NSArray arrayWithObjects:achievement, nil];
        [GKAchievement reportAchievements: achievementsToComplete withCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"Error in reporting achievements: %@", error);
             }
         }];
 
        
        SKScene *myScene = [[cutScene1 alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
        [self.view presentScene:myScene transition:transition];
    }else if ([node.name isEqualToString:@"leaderBoardButton"]){
        NSLog(@"Hit Leaderboard!!");
        [self presentLeaderboards];
        
    }else{
        
    }
}

- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak GKLocalPlayer *_localPlayer =localPlayer;
    _localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil)
        {
            NSLog(@"Logged In");
        }
        else if (_localPlayer.isAuthenticated)
        {
            [self authenticatedPlayer: _localPlayer];
        }
        else
        {
            [self disableGameCenter];
        }
    };
}

-(void)authenticatedPlayer: (GKLocalPlayer*) localPlayer
{
    NSLog(@"Logged In %@",[[GKLocalPlayer localPlayer]alias]);
    
}

-(void)disableGameCenter
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Center Disabled"
                                                    message:@"To enable leaderboards you must sign in to Game Center from the settings menu or Game Center itself."
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void) presentLeaderboards {
    GKGameCenterViewController* gameCenterController = [[GKGameCenterViewController alloc] init];
    gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
    gameCenterController.gameCenterDelegate = self;
    [self.view.window.rootViewController presentViewController:gameCenterController animated:YES completion:nil];
}

- (void) gameCenterViewControllerDidFinish:(GKGameCenterViewController*) gameCenterViewController {
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
