#import  "LCWildcardTermEnum.h"
#import  "LCIndexReader.h"


static void replaceInString(NSMutableString* string, NSString* search, NSString* replace)
{
  NSRange       range;
  unsigned int  count = 0;
  unsigned int  newEnd;
  NSRange       searchRange;

    NSCParameterAssert(search);
    NSCParameterAssert(replace);

  searchRange = NSMakeRange(0, [string length]);
  range = [string rangeOfString: search options: 0 range: searchRange];

  if (range.length > 0)
    {
      unsigned  replaceLen = [replace length];

      do
        {
          count++;
          [string replaceCharactersInRange: range
                              withString: replace];

          newEnd = NSMaxRange(searchRange) + replaceLen - range.length;
          searchRange.location = range.location + replaceLen;
          searchRange.length = newEnd - searchRange.location;

          range = [string rangeOfString: search
                              options: 0
                                range: searchRange];
        }
      while (range.length > 0);
    }
}

@interface LCWildcardTermEnumerator (LCPrivate)
- (BOOL) wildcardEqualsTo: (NSString *) text;
@end

/**
 * Subclass of FilteredTermEnum for enumerating all terms that match the
 * specified wildcard filter term.
 * <p>
 * Term enumerations are always ordered by Term.compareTo().  Each term in
 * the enumeration is greater than all that precede it.
 *
 * @version $Id$
 */

/**
* Creates a new <code>WildcardTermEnum</code>.  Passing in a
 * {@link org.apache.lucene.index.Term Term} that does not contain a
 * <code>WILDCARD_CHAR</code> will cause an exception to be thrown.
 * <p>
 * After calling the constructor the enumeration is already pointing to the first 
 * valid term if such a term exists.
 */

@implementation LCWildcardTermEnumerator

- (id) initWithReader: (LCIndexReader *) reader term: (LCTerm *) term
{
	self = [self init];
	endEnum = NO;
	searchTerm =[ term copy];
	field =[ [searchTerm field] copy];
	text =[ [searchTerm text] copy];
	
	/* Make '*' to be '.*', '?' to be '.?' for regular expression */
	NSMutableString *ms = [[NSMutableString alloc] initWithString: text];
        replaceInString(ms,@"*",@".*");
        replaceInString(ms,@"?",@".?");
    NSError *error = NULL;
    regexp = [NSRegularExpression regularExpressionWithPattern:@"^%@$" options:0 error:&error];
    
	ms=nil;;
	
	LCTerm *t = [[LCTerm alloc] initWithField: field text: @""];
	LCTermEnumerator *e = [reader termEnumeratorWithTerm: t];
	[self setEnumerator: e];
	
	return self;
}

- (void) dealloc
{
	searchTerm=nil;;
	field=nil;;
	text=nil;;
	regexp=nil;;
}

- (BOOL) isEqualToTerm: (LCTerm *) term
{
	if ([field isEqualToString: [term field]])
	{
		return [self wildcardEqualsTo: [term text]];
	}
	endEnum = YES;
	return NO;
}

- (float) difference
{
	return 1.0f;
}

- (BOOL) endOfEnumerator
{
	return endEnum;
}

/* Use OgreKit to match wildcard */
- (BOOL) wildcardEqualsTo: (NSString *) t
{
    NSRange rangeOfFirstMatch = [regexp rangeOfFirstMatchInString:t options:0 range:NSMakeRange(0, [t length])];
    return (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)));
}

- (void) close
{
	[super close];
	searchTerm=nil;;
	field=nil;;
	text=nil;;
	regexp=nil;;
}

@end
