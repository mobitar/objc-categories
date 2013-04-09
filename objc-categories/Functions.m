void applyBlockToObjects(NSArray *objects, void(^block)(id object)) {
    for(id obj in objects) {
        block(obj);
    }
}