//
//  Tower.h
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 25..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldScene.h"

#define FIRING_TICK_TIME 0.3f

@class CCMonster;

@interface CCTower : CCSprite 
{
	CGPoint coordinate;
	int range; // in radius
	int firingTick;
}

+(void) spawn:(CGPoint)coordinate;

-(CCMonster*) findMonsterInRange;

-(void) fire:(CCMonster*)target;

-(CGPoint) getCoordinate;
-(int) getRange;

@end
