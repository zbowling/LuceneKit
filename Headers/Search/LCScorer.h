#ifndef __LUCENE_SEARCH_SCORER__
#define __LUCENE_SEARCH_SCORER__

#import  <Foundation/Foundation.h>
#import  "LCSimilarity.h"
#import  "LCHitCollector.h"
#import  "LCExplanation.h"

@interface LCScorer: NSObject
{
	LCSimilarity *similarity;
}
- (id) initWithSimilarity: (LCSimilarity *) si;
- (LCSimilarity *) similarity;
- (void) score: (LCHitCollector *) hc;
	/* Override by subclass */
- (BOOL) next;
- (int) document;
- (float) score;
- (BOOL) skipTo: (int) target;
- (LCExplanation *) explain: (int) doc;
@end

@interface LCScorer (LCProtected)
- (BOOL) score: (LCHitCollector *) hc maximalDocument: (int) max;
@end

#endif /* __LUCENE_SEARCH_SCORER__ */
