//: Playground - noun: a place where people can play


extension String {
  func indexOf(_ pattern: String) -> String.Index? {
    let patternLength = pattern.characters.count
    assert(patternLength > 0)
    assert(patternLength <= self.characters.count)

    var skipTable = [Character: Int]()
    for (i, c) in pattern.characters.enumerated() {
      skipTable[c] = patternLength - i - 1
    }

#if swift(>=3.0)
    let p = pattern.index(before: pattern.endIndex)
#else
    let p = pattern.endIndex.predecessor()
#endif
    
    let lastChar = pattern[p]
#if swift(>=3.0)
    var i = self.index(self.startIndex, offsetBy: patternLength - 1)
#else
    var i = self.startIndex.advancedBy(patternLength - 1)
#endif

    func backwards() -> String.Index? {
      var q = p
      var j = i
      while q > pattern.startIndex {
#if swift(>=3.0)
            j = self.index(before: j)
            q = self.index(before: q)
#else
        j = j.predecessor()
        q = q.predecessor()
#endif
        if self[j] != pattern[q] { return nil }
      }
      return j
    }

    while i < self.endIndex {
      let c = self[i]
      if c == lastChar {
        if let k = backwards() { return k }
#if swift(>=3.0)
        i = self.index(after:i)
#else
        i = i.successor()
#endif
      } else {
#if swift(>=3.0)
        i = self.index(i, offsetBy:skipTable[c] ?? patternLength)
#else
        i = i.advancedBy(skipTable[c] ?? patternLength)
#endif
      }
    }
    return nil
  }
}



// A few simple tests

let s = "Hello, World"
s.indexOf("World")  // 7

let animals = "🐶🐔🐷🐮🐱"
animals.indexOf("🐮")  // 6
