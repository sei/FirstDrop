//
//  Bullet.m
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 26..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation CCBullet

+(CCBullet*) spawn:(CCTower*)tower monster:(CCMonster*)monster
{
	CCBullet *bullet = [CCBullet spriteWithFile: @"MushroomBlue.png"];
	
	CGPoint startPos = [gTileMapLayer positionAt:[tower getCoordinate]];
	startPos.x += CELL_SIZE / 2;
	startPos.y += CELL_SIZE / 2;
	
	bullet->moveSpeed = 280; // in pixels/sec
	
	bullet->tower = tower;
	bullet->monster = monster;
	
	[bullet setScale: 0.1f];
	[bullet setPosition:startPos];
	[bullet setAnchorPoint:ccp(0.f, 0.f)];
	
	[gLayer addChild:bullet];
	
	[tower schedule:@selector(tick:) interval:FIRING_TICK_TIME];
	
	// distance/bullet moveSpeed 만큼의 시간이 지난 후의 타겟 몬스터 포지션을 계산해서 거기로 move
	
	// FP = P1 + (v1 * t) = P2 + (v2 * t)
	// P1 - P2 = (v2 * t) - (v1 * t) = (v2 - v1) * t
	// t = (P1 - P2) / (v2 - v1)
	// pow(t) = pow(P1 - P2) / pow (v2 - v1)
	
//	float monsterMoveCellUnit = intersectionTime / MONSTER_TICK_TIME;
//	int monsterMoveCellCount = (int)monsterMoveCellUnit;
//	float monsterMoveDeltaRemain = monsterMoveCellUnit - monsterMoveCellCount;
	
	
	//id moveToAction = [CCMoveTo actionWithDuration:intersectionTime position:targetDestinationPos];
	//id moveFinishedAction = [CCCallFuncN actionWithTarget:bullet selector:@selector(moveFinished:)];
	//[bullet runAction:[CCSequence actions:moveToAction, moveFinishedAction, nil]];
	
	CGPoint targetPos = [bullet calcTargetPos];
	float travelTime = [bullet calcTravelTime:targetPos];
	
	CCAction *spriteMoveToAction = [CCMoveTo actionWithDuration:travelTime position:targetPos];
	[bullet runAction:spriteMoveToAction];
	
	[bullet schedule:@selector(tick:) interval:BULLET_TICK_TIME];//tower->speed];
	
	return bullet;
}

-(void) tick:(ccTime)dt
{	
	CGPoint targetPos = [self calcTargetPos];
	float travelTime = [self calcTravelTime:targetPos];
	
	// distance / bullet 의 moveSpeed 만큼의 시간 지난 후의 타겟 몬스터 포지션을 계산해서 거기로 fire
	
	if (travelTime > BULLET_TICK_TIME)
	{
		CCAction *spriteMoveToAction = [CCMoveTo actionWithDuration:travelTime position:targetPos];
		[self runAction:spriteMoveToAction];
	}
	else
	{
		[self setPosition:monster.position];
		[gLayer removeChild:self cleanup:YES];
		
		[monster hitBy:tower bullet:self];
	}
}

-(CGPoint) calcTargetPos
{
	CGPoint targetMonsterPos = monster.position;
	targetMonsterPos.x += CELL_SIZE / 2;
	targetMonsterPos.y += CELL_SIZE / 2;
	
	int monsterCellIndex = [monster getCellIndex];
	CGPoint targetMonsterNextPos = [gTileMapLayer positionAt:[HelloWorld getCellCoordinateAtIndex:monsterCellIndex + 1]];
	targetMonsterNextPos.x += CELL_SIZE / 2;
	targetMonsterNextPos.y += CELL_SIZE / 2;
	
	CGPoint monsterMoveDelta = ccpSub(targetMonsterNextPos, targetMonsterPos);
	
	return ccp(targetMonsterPos.x + monsterMoveDelta.x * BULLET_TICK_TIME,
			   targetMonsterPos.y + monsterMoveDelta.y * BULLET_TICK_TIME);
}

-(float) calcTravelTime:(CGPoint)targetPos
{
	float deltaX = abs(self.position.x - targetPos.x);
	float deltaY = abs(self.position.y - targetPos.y);
	
	float deltaXSquared = deltaX * deltaX;
	float deltaYSquared = deltaY * deltaY;
	
	float travelDistance = sqrt(deltaXSquared + deltaYSquared);
	
	return travelDistance / moveSpeed;
}

-(bool) hasHitTarget
{
	CGRect monsterHitBox = [monster boundingBox];
	//monsterHitBox.size.width += MONSTER_HIT_MARGIN;
	//monsterHitBox.size.height += MONSTER_HIT_MARGIN;
	
	if (CGRectContainsPoint(monsterHitBox, self.position))	
	{
		return true;
	}
	
	return false;
}	
	
-(void) moveFinished:(ccTime)dt
{
	[gLayer removeChild:self cleanup:YES];
}

@end
