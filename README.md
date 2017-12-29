# ruby-scripts
The main purpose of this repo is to enjoy the art of programming and to practice more algorithmic approach for some more or less common problems.

Quick note for the sake of clarification:
Most of the time I decided to focus on algorithms implementation itself (by hand), rather than using more idiomatic and
sophisticated Ruby style. In some cases there are both implementations, but it is not a rule of thumb. Great example to
explain my point of view is to skip Enumerable module. There is no doubt that Enumerable module contains extremely useful
filtering, sorting and transformation related add-ons. There is no doubt either, that conventions adopted by community 
exists for a reason. Many algorithms implemented here probably could be easily (or not) replaced with some other, more 
common and suitable solutions.
I just love to explore Ruby, as well as digging into how something has been, or need to be implemented. 
Please, feel welcome to open issues and comment on that :)

**Algorithms** -
This section is mostly focused on covering transformations related to text-processing, but not only. These are definitely crucial basics for everyone who wants to understand Natural Language Processing engines. There are also implementation for several common and uncommon searching and sorting algorithms.

**Performance** -
This section is mostly focused on playing with complex Ruby syntax. With such an expanded programming language, in most cases there is a lot of solutions for the particular problem. I strongly believe that context of performance matters.

**Metaprogramming** -
This section is mostly focused on building simple code snippets for solid understanding of different meta programming techniques.

**Patterns** -
This section is mostly focused on revealing and solidify understanding of different patterns in programming. Most of the time I decided to stay focused on patterns described by GOF in their great publication - 'Design Patterns: Elements of Reusable Object-Oriented Software' (1994).

### Algorithms
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


### Performance
  - Arrays
    - Array#join vs other less common approaches
    - Counting occurrence of array elements
  - Strings
    - Multiple choices for removing first char

### Metaprogramming
- Different ways to define singleton method

### Patterns
  - Singleton (under development)

### Data Structures
- Linked List (with basic actions)
- Circular List (with basic actions)
