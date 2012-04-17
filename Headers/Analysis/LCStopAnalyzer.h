#ifndef __LUCENE_ANALYSIS_STOP_ANALYZER__
#define __LUCENE_ANALYSIS_STOP_ANALYZER__

#import  "LCAnalyzer.h"

#ifdef HAVE_UKTEST
#import  <UnitKit/UnitKit.h>
@interface LCStopAnalyzer: LCAnalyzer <UKTest>
#else
@interface LCStopAnalyzer: LCAnalyzer
#endif
{
	NSSet *stopWords;
	NSArray *ENGLISH_STOP_WORDS;
}

- (id) initWithStopWords: (NSArray *) sw;

@end

#endif /* __LUCENE_ANALYSIS_STOP_ANALYZER__ */
