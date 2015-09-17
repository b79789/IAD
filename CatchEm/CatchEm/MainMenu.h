//
//  MainMenu.h
//  CatchEm
//
//  Created by Brian Stacks on 8/26/15.
//  Copyright (c) 2015 Brian Stacks. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>


@interface MainMenu : SKScene<GKGameCenterControllerDelegate>
@property(assign, nonatomic) id< GKGameCenterControllerDelegate > gameCenterDelegate;

@end
