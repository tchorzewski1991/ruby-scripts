class List
  attr_accessor :head

  def insert(data)
    self.head = Node.new(data, head)
  end

  def search(data, node = head)
    return nil unless node
    return node if data == node.data
    search(data, node.next_node)
  end

  def delete(node)
    if node == head
      tap { self.head = head.next_node }
    else
      successor = node.next_node
      predecessor = head

      loop do
        break if predecessor.next_node == node
        predecessor = predecessor.next_node
      end

      tap { predecessor.next_node = successor }
    end
  end

  def tail
    tail = head

    while node = tail && tail.next_node
      tail = node
    end

    tail
  end

  class Node
    attr_accessor :data, :next_node

    def initialize(data, next_node = nil)
      @data = data
      @next_node = next_node
    end
  end
end
