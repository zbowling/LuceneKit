#ifndef __LUCENE_ANALYSIS_WHITESPACE_ANALYZER__
#define __LUCENE_ANALYSIS_WHITESPACE_ANALYZER__

#import  "LCAnalyzer.h"

/** An Analyzer that uses WhitespaceTokenizer. */
#ifdef HAVE_UKTEST
#import  <UnitKit/UnitKit.h>
@interface LCWhitespaceAnalyzer: LCAnalyzer <UKTest>
#else
@interface LCWhitespaceAnalyzer: LCAnalyzer
#endif

@end

#endif /*  __LUCENE_ANALYSIS_WHITESPACE_ANALYZER__ */
