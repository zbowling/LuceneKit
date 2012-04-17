#import  "LCQueryFilter.h"
#import  "LCHitCollector.h"
#import  "LCIndexSearcher.h"
#import  "LCBitVector.h"
#import  "LCQuery.h"


@interface LCQueryFilterHitCollector: LCHitCollector
{
	LCBitVector * bits;
}
- (id) initWithBits: (LCBitVector *) bits;
@end

@implementation LCQueryFilterHitCollector: LCHitCollector
- (id) initWithBits: (LCBitVector *) b
{
	self = [self init];
	bits = b;
	return self;
}

- (void) dealloc
{
  bits=nil;;
}

- (void) collect: (int) doc score: (float) score
{
	[bits setBit: doc];
}
@end

@implementation LCQueryFilter
- (id) initWithQuery: (LCQuery *) q
{
	self = [self init];
	cache = nil;
	query = q;
	return self;
}

- (void) dealloc
{
  query=nil;;
}

- (LCQuery *) query
{
	return query;
}

- (LCBitVector *) bits: (LCIndexReader *) reader
{
	if (cache == nil)
	{
          cache = [[NSMutableDictionary alloc] init];
	}
	
	LCBitVector *cached = [cache objectForKey: reader];
	if (cached != nil) return cached;
	
	LCBitVector *bits = [(LCBitVector *)[LCBitVector alloc] initWithSize: [reader maximalDocument]];
	LCQueryFilterHitCollector *hc = [[LCQueryFilterHitCollector alloc] initWithBits: bits];
	LCIndexSearcher *searcher = [[LCIndexSearcher alloc] initWithReader: reader];
	[searcher search: query hitCollector: hc];
	[cache setObject: bits forKey: reader];
	
	return bits;
}

- (NSString *) description
{
	return [NSString stringWithFormat: @"LCQueryFilter(%@)", query];
}

- (NSUInteger) hash
{
  return [query hash]^0x923F64B9;
}

- (BOOL) isEqual: (id) o
{
  if (!([o isKindOfClass: [LCQueryFilter class]])) return NO;
  return [query isEqual: [(LCQueryFilter *)o query]];
}

@end
