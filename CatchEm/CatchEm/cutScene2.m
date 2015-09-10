//
//  cutScene2.m
//  CatchEm
//
//  Created by Brian Stacks on 9/10/15.
//  Copyright (c) 2015 Brian Stacks. All rights reserved.
//

#import "cutScene2.h"
#import "GameScene.h"



@implementation cutScene2

-(id)initWithSize:(CGSize)size{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (self = [super initWithSize:size]) {
        SKSpriteNode *cut = [SKSpriteNode spriteNodeWithImageNamed:@"cutScene2.png"];
        cut.size =CGSizeMake(screenWidth, screenHeight);
        cut.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        cut.name = @"cut2";
        [self addChild:cut];
        
        SKSpriteNode *start = [SKSpriteNode spriteNodeWithImageNamed:@"Go-Button.png"];
        start.position = CGPointMake(CGRectGetMidX(self.frame)+225, CGRectGetMidY(self.frame)- 225);
        start.name = @"Go";
        [self addChild:start];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"Go"]) {
        SKScene *myScene = [[GameScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
        [self.view presentScene:myScene transition:transition];
    }
}

@end
