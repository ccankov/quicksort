class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = rand(array.length).floor
    left, right = [], []
    array.each_with_index do |el, idx|
      next if idx == pivot
      el <= array[pivot] ? left << el : right << el
    end

    sort1(left) + [array[pivot]] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    pivot_idx = partition(array, start, length, &prc)
    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - ((pivot_idx - start) + 1), &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    return if length < 2
    prc ||= proc { |el1, el2| el1 <=> el2 }
    pivot = start
    partition_index = start + 1
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(array[idx], array[pivot]) < 1
        array[idx], array[partition_index] = array[partition_index], array[idx]
        partition_index += 1
      end
    end
    array[pivot], array[partition_index - 1] = array[partition_index - 1], array[pivot]
    partition_index - 1
  end
end
