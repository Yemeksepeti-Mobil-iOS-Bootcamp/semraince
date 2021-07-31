import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            assertionFailure("The index is out of the range.")
            return nil
        }

        return self[index]
    }
}

extension Collection {
    func count(where predicate: (Element) -> Bool) -> Int {
        var count = 0
        for element in self where predicate(element) {
            count += 1
        }
        return count
    }
}

