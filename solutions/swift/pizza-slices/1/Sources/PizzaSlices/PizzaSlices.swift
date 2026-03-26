func sliceSize(diameter: Double?, slices: Int?) -> Double? {
    guard let diameter = diameter,
          let slices = slices else {
          return nil
    }
    guard diameter >= 0 && slices >= 1 else {
          return nil
    }
    let radius = diameter / 2
    let totalArea = Double.pi * radius * radius
    let sliceArea = totalArea / Double(slices)
    return sliceArea
}

func biggestSlice(diameterA: String, slicesA: String,
                  diameterB: String, slicesB: String) -> String {
    func sliceArea(diameterString: String, slicesString: String) -> Double? {
        guard let diameter = Double(diameterString),
              let slices   = Int(slicesString) else {
              return nil
        }
        return sliceSize(diameter: diameter, slices: slices)
    }

    let sliceAreaA = sliceArea(diameterString: diameterA, slicesString: slicesA)
    let sliceAreaB = sliceArea(diameterString: diameterB, slicesString: slicesB)

    switch (sliceAreaA, sliceAreaB) {
    case let (.some(areaA), .some(areaB)):
        if areaA > areaB { return "Slice A is bigger" }
        if areaB > areaA { return "Slice B is bigger" }
        return "Neither slice is bigger"
    case (.some, .none): return "Slice A is bigger"
    case (.none, .some): return "Slice B is bigger"
    case (.none, .none): return "Neither slice is bigger"
    }
}
