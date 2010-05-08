//
//  Tower.m
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 25..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Tower.h"
#import "Bullet.h"


@implementation CCTower

+(void) spawn:(CGPoint)coordinate
{
	CCTower *tower = [CCTower spriteWithFile: @"MushroomRed.png"];
	
	tower->coordinate = coordinate;
	tower->range = 60;
	//tower->speed = 0.1f;
	CGPoint position = [gTileMapLayer positionAt:coordinate];
	
	[tower setScale: 0.3f];
	[tower setPosition:position];
	[tower setAnchorPoint:ccp(0.f, 0.f)];
	
	[gLayer addTower:tower];
	
	[tower schedule:@selector(tick:) interval:FIRING_TICK_TIME];//tower->speed];
	//[monster schedule:@selector(update:)];
}

-(void) tick:(ccTime)dt
{
	CCMonster *monster = [self findMonsterInRange];
	if (monster)
	{
		[self fire:monster];
	}
}

-(CCMonster*) findMonsterInRange
{
	CGPoint towerPos = [gTileMapLayer positionAt:coordinate];
	float rangeSquared = range * range;
	
	for (CCMonster *monster in [gLayer getMonsters])
	{
		CGPoint monsterPos = [gTileMapLayer positionAt:[HelloWorld getCellCoordinateAtIndex:[monster getCellIndex]]];
		
		float xDiff = abs(towerPos.x - monsterPos.x);
		float yDiff = abs(towerPos.y - monsterPos.y);
		
		float xDiffSquared = xDiff * xDiff;
		float yDiffSquared = yDiff * yDiff;
		
		if (xDiffSquared + yDiffSquared < rangeSquared)
		{
			return monster;
		}
	}
	
	return nil;
}

-(void) fire:(CCMonster*)target
{
	[CCBullet spawn:self monster:target];
}

-(CGPoint) getCoordinate
{
	return coordinate;
}

-(int) getRange
{
	return range;
}

@end
