class List
  include Enumerable
  attr_accessor :head

  def insert(data)
    self.head = Node.new(data, head)
  end

  def search(data, node = head)
    return nil unless node
    return node if data == node.data
    search(data, node.next_node)
  end

  def delete(doomed)
    if doomed == head
      return tap { self.head = head.next_node }
    end

    successor = doomed.next_node
    predecessor = find { |node| doomed == node.next_node }

    tap { predecessor.next_node = successor }
  end

  def tail
    find { |node| node.next_node.nil? }
  end

  def each
    node = head
    while node
      yield(node)
      node = node.next_node
      break if node.nil?
    end
  end

  class Node
    attr_accessor :data, :next_node

    def initialize(data, next_node = nil)
      @data = data
      @next_node = next_node
    end
  end
end
