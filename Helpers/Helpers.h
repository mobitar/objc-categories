void applyBlockToObjects(NSArray *objects, void(^block)(id object));
void applyBlockToObjectsWithDelayBetweenObjects(NSArray *objects, CGFloat delayBetweenObjects, void(^block)(id object));
void applyBlockToObjectsWithDelayBetweenObjectsAndCompletion(NSArray *objects,
                                                             CGFloat delayBetweenObjects, void(^block)(id object), void(^completion)());

NSValue *NSValueWithCATransform3D(CATransform3D transform);
void async(void(^block)());