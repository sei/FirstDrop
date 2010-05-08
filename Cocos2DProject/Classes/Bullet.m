//
//  Bullet.m
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 26..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation CCBullet

+(void) spawn:(CCTower*)tower monster:(CCMonster*)monster
{
	CCBullet *bullet = [CCBullet spriteWithFile: @"MushroomBlue.png"];
	
	bullet->pos = bullet->startPos = [gTileMapLayer positionAt:[tower getCoordinate]];
	bullet->pos.x += CELL_SIZE / 2;
	bullet->pos.y += CELL_SIZE / 2;
	
	bullet->moveSpeed = 130; // in pixels/sec
	
	[bullet setScale: 0.1f];
	[bullet setPosition:bullet->pos];
	[bullet setAnchorPoint:ccp(0.f, 0.f)];
	
	[gLayer addChild:bullet];
	
	
	// distance/bullet moveSpeed 만큼의 시간이 지난 후의 타겟 몬스터 포지션을 계산해서 거기로 move
	int monsterCellIndex = [monster getCellIndex];
	CGPoint targetMonsterPos = [gTileMapLayer positionAt:[HelloWorld getCellCoordinateAtIndex:monsterCellIndex]];
	CGPoint targetMonsterNextPos = [gTileMapLayer positionAt:[HelloWorld getCellCoordinateAtIndex:monsterCellIndex + 1]];
	
	targetMonsterNextPos.x += CELL_SIZE / 2;
	targetMonsterNextPos.y += CELL_SIZE / 2;
	
	float deltaX = abs(bullet->pos.x - targetMonsterNextPos.x);
	float deltaY = abs(bullet->pos.y - targetMonsterNextPos.y);
	
	// bullet dist / bullet speed = monster dist / monster speed
	// monster dist = (monster speed * bullet dist) / bullet speed
	
	float monsterMoveDist = [monster getSpeed] * [tower getRange] / bullet->moveSpeed;
	
	CGPoint targetDestinationPos;
	if (targetMonsterNextPos.x > targetMonsterPos.x)
	{
		// moving right
		targetDestinationPos.x = targetMonsterPos.x + monsterMoveDist;
	}
	else if (targetMonsterNextPos.x < targetMonsterPos.x)
	{
		// moving left
		targetDestinationPos.x = targetMonsterPos.x - monsterMoveDist;
	}	
	else if (targetMonsterNextPos.y > targetMonsterPos.y)
	{
		// moving up
		targetDestinationPos.y = targetMonsterPos.y + monsterMoveDist;
	}	
	else 
	{
		// moving down
		targetDestinationPos.y = targetMonsterPos.y - monsterMoveDist;
	}

	targetDestinationPos.x += CELL_SIZE / 2;
	targetDestinationPos.y += CELL_SIZE / 2;
	
	//float deltaX = abs(bullet->pos.x - targetDestinationPos.x);
	//float deltaY = abs(bullet->pos.y - targetDestinationPos.y);
	
	float deltaXSquared = deltaX * deltaX;
	float deltaYSquared = deltaY * deltaY;
	
	float travelDistance = sqrt(deltaXSquared + deltaYSquared);
	float travelTime = travelDistance / bullet->moveSpeed;
	
	//id moveToAction = [CCMoveTo actionWithDuration:travelTime position:targetMonsterNextPos];
	id moveToAction = [CCMoveTo actionWithDuration:travelTime position:targetDestinationPos];
	id moveFinishedAction = [CCCallFuncN actionWithTarget:bullet selector:@selector(moveFinished:)];
	[bullet runAction:[CCSequence actions:moveToAction, moveFinishedAction, nil]];
}

-(void) tick:(ccTime)dt
{
	// distance / bullet 의 moveSpeed 만큼의 시간 지난 후의 타겟 몬스터 포지션을 계산해서 거기로 fire
	
}

-(void) moveFinished:(ccTime)dt
{
	[gLayer removeChild:self cleanup:YES];
}

@end
