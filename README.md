# What is this?

This repository contains Ruby implementation of various algorithms and data structures.

**Quick note for the sake of clarification:**

This code was designed more for learning purposes. Some of the proposed solutions might not fall into 100% idiomatic Ruby.
You probably want to use a different Ruby library, if you are interested in code crafted directly for **production** use.
There are several ones. The `algorithms` gem makes use of C-extensions for significant speed improvement.
I won't say my code doesn't work and cannot be used commercially, but it's always worth to know about possible alternatives :)

Most of the time I decided to focus on algorithms implementation itself, rather than using ready solutions.
In some cases, there are both implementations, but it is not a rule of thumb. I strongly believe that digging into how
something has been, or needs to be implemented is a great opportunity to develop programming skills.

Please, feel welcome to open issues and comment on that :)

**Algorithms** -
This section is mostly focused on covering transformations related to text-processing.
You can find here some basics of natural language processing as well as several common and uncommon searching and sorting algorithms.

**Performance** -
This section is focused mostly on writing performant Ruby code. In most cases, we are faced with several possible solutions to a given problem. Premature optimization is the root of all evil, but I strongly believe that the context of performance matters - especially in case of such expressive and flexible language as Ruby.

**Metaprogramming** -
This section is focused mostly on a deep understanding of different metaprogramming techniques.

**Patterns** -
This section is mostly focused on revealing and solidify understanding of different patterns in programming. Most of
the time I decided to stay focused on patterns described by GOF in their great publication - 'Design Patterns: Elements
of Reusable Object-Oriented Software' (1994).



#### Algorithms
- Text-Processing
  - Hamming distance
  [wiki](https://en.wikipedia.org/wiki/Hamming_distance)
  - Levenshtein distance [wiki](https://en.wikipedia.org/wiki/Levenshtein_distance)
  - Jaro distance [wiki](https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance)
  - Jaro-Winkler distance
  [wiki](https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance)
  - Knuth-Morris-Pratt longest common subsequence
  [wiki](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm)
  - Word Cosine Similarity
  [wiki](https://en.wikipedia.org/wiki/Cosine_similarity)
  - Jaccard coefficient/distance
  [wiki](https://en.wikipedia.org/wiki/Jaccard_index)

- Sorting
  - Bubble sort
  - Selection sort
  - Insertion sort

- Searching
  - Linear search
  - Binary search

- External-enumerators
  - Modulo - external enumerator that returns n first numbers where number % another number equals to 0.
  - Interpose - external enumerator that returns collection with given separator interposed between elements.
  - PrimeNumbers - external enumerator that returns n first prime numbers.

- Other
  - Recursive/Iterative Fibonacci
  - Lunh
    [wiki](https://en.wikipedia.org/wiki/Luhn_algorithm)


#### Performance
  - Arrays
    - Array#join vs other less common approaches
    - Counting occurrence of array elements
  - Strings
    - Multiple choices for removing first char

#### Metaprogramming
  - Different ways to define singleton method

#### Patterns
  - Singleton

#### Data Structures
  - Linked List (with basic actions)
  - Circular List (with basic actions)


## License
All Solutions licensed under MIT License. See LICENSE.txt for further details.

## Copyright
Copyright (c) 2018 [tchorzewski1991](https://github.com/tchorzewski1991).
