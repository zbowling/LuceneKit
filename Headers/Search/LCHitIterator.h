#ifndef __LUCENE_SEARCH_HIT_ITERATOR__
#define __LUCENE_SEARCH_HIT_ITERATOR__

#import  <Foundation/Foundation.h>

@class LCHits;
@class LCHit;

@interface LCHitIterator: NSObject
{
	LCHits *hits;
	int hitNumber;
}
- (id) initWithHits: (LCHits *) hits;
- (BOOL) hasNext;
- (LCHit *) next;
- (int) count;

@end

#endif /* __LUCENE_SEARCH_HIT_ITERATOR__ */
