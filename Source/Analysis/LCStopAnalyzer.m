#import  "LCStopAnalyzer.h"
#import  "LCStopFilter.h"
#import  "LCLowerCaseTokenizer.h"


/** Filters LetterTokenizer with LowerCaseFilter and StopFilter. */
@implementation LCStopAnalyzer

/** Builds an analyzer which removes words in ENGLISH_STOP_WORDS. */
- (id) init
{
	/** An array containing some common English words that are not usually useful
    for searching. */
	ENGLISH_STOP_WORDS = [[NSArray alloc] initWithObjects:
		@"a", @"an", @"and", @"are", @"as", @"at", @"be", @"but", @"by",
		@"for", @"if", @"in", @"into", @"is", @"it",
		@"no", @"not", @"of", @"on", @"or", @"s", @"such",
		@"t", @"that", @"the", @"their", @"then", @"there", @"these",
		@"they", @"this", @"to", @"was", @"will", @"with", nil];
	self = [self initWithStopWords: ENGLISH_STOP_WORDS];
	return self;
}

- (id) initWithStopWords: (NSArray *) sw
{
	self = [super init];
	stopWords = [[NSSet alloc] initWithSet: [LCStopFilter makeStopSet: sw]];
	return self;
}

#if 0
  /** Builds an analyzer with the stop words from the given set.
 	    */
 	   public StopAnalyzer(Set stopWords) {
 	     this.stopWords = stopWords;
 	   }
#endif

/* LuceneKit: TODO */
#if 0
/** Builds an analyzer with the stop words from the given file. */
public StopAnalyzer(File stopwordsFile) throws IOException {
	stopWords = WordlistLoader.getWordSet(stopwordsFile);
}

public StopAnalyzer(Reader stopwords) {
  stopWords = WordlistLoader.getWordSet(stopwords);
}
#endif

- (void) dealloc
{
	ENGLISH_STOP_WORDS=nil;;
	stopWords=nil;;
}

/** Filters LowerCaseTokenizer with StopFilter. */
- (LCTokenStream *) tokenStreamWithField: (NSString *) name
								  reader: (id <LCReader>) reader
{
	LCLowerCaseTokenizer *tokenizer = [[LCLowerCaseTokenizer alloc] initWithReader: reader];
	LCStopFilter *filter = [[LCStopFilter alloc] initWithTokenStream: tokenizer
													  stopWordsInSet: stopWords];
	tokenizer=nil;;
	return filter;
}

@end
