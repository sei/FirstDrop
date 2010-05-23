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

@synthesize attackDamage = m_fAttackDamage;

+(void) spawn:(CGPoint)coordinate
{

	if (coordinate.y >= CELL_COUNT_Y - 1)
		return;
	
	int gid = [gTileMapLayer tileGIDAt:coordinate];
	if (TILE_PATH_GID == gid || TILE_START_POINT_GID == gid || TILE_END_POINT_GID == gid)
		return;

	
	if (mapTowers[(int)coordinate.x][(int)coordinate.y] != 0)
	{
		return;
	}
	else {
		mapTowers[(int)coordinate.x][(int)coordinate.y] = 1;
	}

	CCTower *tower = [CCTower spriteWithFile: @"MushroomRed.png"];
	
	tower->coordinate = coordinate;
	tower->range = 60;
	//tower->speed = 0.1f;
	
	tower->m_fAttackDamage = 10;
	
	CGPoint position = [gTileMapLayer positionAt:coordinate];
	
	[tower setScale: 0.3f];
	[tower setPosition:position];
	[tower setAnchorPoint:ccp(0.f, 0.f)];
	
	tower->bullets = [[NSMutableArray alloc] init];
	
	[gLayer addTouchable:tower];
	//[gLayer addTower:tower];
	
	[tower schedule:@selector(tick:) interval:FIRING_TICK_TIME];//tower->speed];
}

-(void) tick:(ccTime)dt
{	
	CCMonster *monster = [self findMonsterInRange];
	if (monster)
	{
		[self fire:monster];
	}
	
	tickCount++;
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
	CCBullet *bullet = [CCBullet spawn:self monster:target];
	[bullets addObject:bullet];
	
	[target shotBy:bullet];
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
