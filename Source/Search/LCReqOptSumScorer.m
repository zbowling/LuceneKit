#import  "LCReqOptSumScorer.h"


@implementation LCReqOptSumScorer

- (id) initWithRequired: (LCScorer *) r optional: (LCScorer *) o
{
	self = [self initWithSimilarity: nil];
	reqScorer = r;
	optScorer = o;
	firstTimeOptScorer = YES;
	return self;
}

- (void) dealloc
{
	reqScorer=nil;;
	optScorer=nil;;
}

- (BOOL) next
{
	return [reqScorer next];
}

- (BOOL) skipTo: (int) target
{
	return [reqScorer skipTo: target];
}

- (int) document
{
	return [reqScorer document];
}

- (float) score
{
	int curDoc = [reqScorer document];
	float reqScore = [reqScorer score];
	if (firstTimeOptScorer) {
		firstTimeOptScorer = NO;
		if (![optScorer skipTo: curDoc]) {
			optScorer=nil;;
			return reqScore;
		}
	} else if (optScorer == nil) {
		return reqScore;
	} else if (([optScorer document] < curDoc) && (![optScorer skipTo: curDoc])) {
		optScorer=nil;;
		return reqScore;
	}
	
	return ([optScorer document] == curDoc) ? (reqScore + [optScorer score]) : reqScore;
}

- (LCExplanation *) explain: (int) doc
{
	LCExplanation *res = [[LCExplanation alloc] init];
	[res setRepresentation: @"required, optional"];
	[res addDetail: [reqScorer explain: doc]];
	[res addDetail: [optScorer explain: doc]];
	return res;
}

@end
