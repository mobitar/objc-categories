
void applyBlockToObjects(NSArray *objects, void(^block)(id object)) {
    for(id obj in objects) {
        block(obj);
    }
}

void applyBlockToObjectsWithDelayBetweenObjects(NSArray *objects, CGFloat delayBetweenObjects, void(^block)(id object)) {
    CGFloat currentOffset = 0;
    for(id obj in objects) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(currentOffset * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            block(obj);
        });
        currentOffset += delayBetweenObjects;
    }
}

void applyBlockToObjectsWithDelayBetweenObjectsAndCompletion(NSArray *objects, CGFloat delayBetweenObjects, void(^block)(id object), void(^completion)()) {
    CGFloat totalOffset = ((objects.count - 1) * delayBetweenObjects) + delayBetweenObjects;
    applyBlockToObjectsWithDelayBetweenObjects(objects, delayBetweenObjects, block);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(totalOffset * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
    });
}

NSValue *NSValueWithCATransform3D(CATransform3D transform) {
    return [NSValue valueWithCATransform3D:transform];
}

void async(void(^block)()) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}
