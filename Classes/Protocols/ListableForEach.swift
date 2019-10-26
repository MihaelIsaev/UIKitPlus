protocol ListableForEach {
    func subscribeToChanges(_ handler: @escaping (_ deletions: [Int], _ insertions: [Int], _ reloads: [Int]) -> Void)
}
