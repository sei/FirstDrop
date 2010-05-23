//
//  Monster.h
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 23..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldScene.h"

#define MONSTER_TICK_TIME 0.3f

@class CCTower;
@class CCBullet;

@interface CCMonster : CCSprite 
{
	int cellIndex;
	float speed; // in pixels/sec
	
	float m_fHP;		// 체력
	float m_fArmor;		// 방어력
	float m_fMoney;		// 돈 올라가는 수치
	
	NSMutableArray *m_myBullets;	// 해당 몬스터를 타겟으로 삼은 불릿들
}

+(void) spawn;
//-(void) despawn:(ccTime)dt;
-(void) despawn;
-(void) tick:(ccTime)dt;

-(void) moveToNextCell:(ccTime)dt;

-(void) shotBy:(CCBullet*)bullet;
-(void) hitBy:(CCTower*)tower bullet:(CCBullet*)bullet;

-(int) getCellIndex;
-(float) getSpeed;


@property(nonatomic,readwrite,assign) NSMutableArray *myBullets;

@end
