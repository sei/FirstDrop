//
//  Bullet.h
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 26..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldScene.h"

#define BULLET_TICK_TIME 0.1f

@interface CCBullet : CCSprite 
{
	CCTower *tower;
	CCMonster *monster;
	
	float moveSpeed; // in pixels/sec
}

+(CCBullet*) spawn:(CCTower*)tower monster:(CCMonster*)monster;
-(void) tick:(ccTime)dt;

-(CGPoint) calcTargetPos;
-(float) calcTravelTime:(CGPoint)targetPos;

-(bool) hasHitTarget;
-(void) moveFinished:(ccTime)dt;

@end
