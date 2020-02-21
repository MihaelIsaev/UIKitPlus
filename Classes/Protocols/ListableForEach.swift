protocol ListableForEach {
    func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping (_ deletions: [Int], _ insertions: [Int], _ reloads: [Int]) -> Void, _ end: @escaping () -> Void)
}
