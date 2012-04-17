#ifndef __LUCENE_SEARCH_WEIGHT__
#define __LUCENE_SEARCH_WEIGHT__

#import  <Foundation/Foundation.h>
#import  "LCIndexReader.h"
#import  "LCScorer.h"
#import  "LCExplanation.h"

@class LCQuery;

@protocol LCWeight <NSObject> //Serializable
- (LCQuery *) query;
- (float) value;
- (float) sumOfSquaredWeights;
- (void) normalize: (float) norm;
- (LCScorer *) scorer: (LCIndexReader *) reader;
- (LCExplanation *) explain: (LCIndexReader *) reader
				   document: (int) doc;
@end
#endif /* __LUCENE_SEARCH_WEIGHT__ */
