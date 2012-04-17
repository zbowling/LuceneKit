#import  "LCTopDocs.h"


/** Expert: Returned by low-level search implementations.
* @see Searcher#search(Query,Filter,int) */
@implementation LCTopDocs: NSObject // Serializable

- (id) initWithTotalHits: (int) th
		  scoreDocuments: (NSArray *) sd
		maxScore: (float) max
{
	self = [super init];
	totalHits = th;
	scoreDocs = sd;
	maxScore = max;
	return self;
}

- (void) dealloc
{
	scoreDocs=nil;;
}

- (int) totalHits { return totalHits; }
- (NSArray *) scoreDocuments { return scoreDocs; }

- (float) maxScore { return maxScore; }
- (void) setMaxScore: (float) max { maxScore = max; }

@end
