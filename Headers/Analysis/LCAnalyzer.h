#ifndef __LUCENE_ANALYSIS_ANALYZER__
#define __LUCENE_ANALYSIS_ANALYZER__

#import  <Foundation/Foundation.h>
#import  "LCReader.h"
#import  "LCTokenStream.h"

@interface LCAnalyzer: NSObject
{
}

/* Return a stream of token */
- (LCTokenStream *) tokenStreamWithField: (NSString *) name
                                  reader: (id <LCReader>) reader;
- (int) positionIncrementGap: (NSString *) fieldName;
@end

#endif /* __LUCENE_ANALYSIS_ANALYZER__ */
