#let pull_entries(data, only: ()) = {
  if only == "hidden" {
    return ()
  }
  if type(only) != array or only.len() == 0 {
    return data
  }
  let mapping = (:)
  for entry in data {
    if "id" in entry {
      mapping.insert(entry.id, entry)
    }
  }
  let result = ()
  for id in only {
    if id in mapping {
      let entry = mapping.at(id)
      if "inherit" in entry and entry.inherit in mapping {
        entry = mapping.at(entry.inherit) + entry
      }
      result.push(entry)
    }
  }
  return result
} 

#let stick_together(a, b, threshold: 3em) = {
  block(a + v(threshold), breakable: false)
  v(-1 * threshold)
  b
}

#let equal_columns(column_count: 1) = {
  return range(column_count).map(_ => 1fr)
}