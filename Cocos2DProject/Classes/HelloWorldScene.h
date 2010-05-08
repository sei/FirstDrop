
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Monster.h"
#import "Tower.h"

#define TILE_PATH_GID			39
#define TILE_START_POINT_GID	134
#define TILE_END_POINT_GID		151

#define START_POINT_COORDINATE	ccp(0, 1)

#define CELL_SIZE				32

#define CELL_COUNT_X			15
#define CELL_COUNT_Y			10

#define PI						3.14159265358979

@class CCMonster;
@class CCTower;

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
	CCTMXTiledMap *tileMap;
	
	NSMutableArray *coordinatePath;
	
	NSMutableArray *towers;
	NSMutableArray *monsters;
	
	CCSprite*	m_tempTower;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) addMonster:(CCMonster*)monster;
-(void) removeMonster:(CCMonster*)monster;
-(NSMutableArray*) getMonsters;

-(void) addTower:(CCTower*)tower;
-(void) removeTower:(CCTower*)tower;
-(NSMutableArray*) getTowers;

-(void) buildCoordinatePath;
-(NSMutableArray*) getCoordinatePath;

+(CGPoint) findNextCell:(CGPoint)coordinate prevCoordinate:(CGPoint)prevCoordinat;

+(bool) isPath:(CGPoint)tileCoordinate;
+(bool) isEndPoint:(CGPoint)tileCoordinate;
+(bool) isInsideBoundary:(CGPoint)tlleCoordinate;

+(CGPoint) getCellCoordinateAtIndex:(int)cellIndex;
+(int) getTileGidAtIndex:(int)cellIndex;
+(bool) isEndPointAtIndex:(int)cellIndex;

@end

extern HelloWorld *gLayer; 
extern CCTMXLayer *gTileMapLayer;
