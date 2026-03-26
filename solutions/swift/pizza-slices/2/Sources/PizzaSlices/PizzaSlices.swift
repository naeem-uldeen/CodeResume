func sliceSize(diameter: Double?, slices: Int?) -> Double? {
    guard let d = diameter,
          let s = slices,
          d >= 0,
          s > 0 else { return nil }

    let radius = d / 2
    return .pi * radius * radius / Double(s)
}

func biggestSlice(diameterA: String, slicesA: String,
                  diameterB: String, slicesB: String) -> String {

    let aBigger  = "Slice A is bigger"
    let bBigger  = "Slice B is bigger"
    let neutral  = "Neither slice is bigger"

    func area(_ diameter: String, _ slices: String) -> Double? {
        guard let d = Double(diameter), let s = Int(slices) else { return nil }
        return sliceSize(diameter: d, slices: s)
    }

    switch (area(diameterA, slicesA), area(diameterB, slicesB)) {
    case let (.some(areaA), .some(areaB)):
        if areaA == areaB { return neutral }
        return areaA > areaB ? aBigger : bBigger
    case (.some, .none): return aBigger
    case (.none, .some): return bBigger
    case (.none, .none): return neutral
    }
}
