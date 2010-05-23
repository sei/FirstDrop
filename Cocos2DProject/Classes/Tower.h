//
//  Tower.h
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 25..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "cocos2d.h"
#import "touchable.h"
#import "HelloWorldScene.h"

#define FIRING_TICK_TIME 0.5f

@class CCMonster;

@interface CCTower : CTouchable //CCSprite 
{
	CGPoint coordinate;
	int range; // in radius
	int firingTick;
	
	float m_fAttackDamage;	// 공격력
	
	NSMutableArray *bullets;
	
	int tickCount;
}

+(void) spawn:(CGPoint)coordinate;
-(void) tick:(ccTime)dt;

-(CCMonster*) findMonsterInRange;

-(void) fire:(CCMonster*)target;

-(CGPoint) getCoordinate;
-(int) getRange;

@property(nonatomic,readwrite,assign) float attackDamage;

@end
