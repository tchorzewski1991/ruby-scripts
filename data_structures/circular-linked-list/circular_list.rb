class CircularList
  include Enumerable
  attr_accessor :head

  def insert(data)
    tap do
      case !!(head)
      when true
        node = Node.new(data, head)
        tail = find { |node| node.next_node == head }
        tail.update_next_node(node)
        self.head = node
      when false
        self.head = Node.new(data)
      end
    end
  end

  def search(data)
    find { |node| data == node.data }
  end

  def delete(doomed)
    tap do
      return if head.nil?

      doomed = find { |node| node == doomed }
      return if doomed.nil?

      case head == head.next_node
      when true
        self.head = nil
      when false
        doomed_successor = doomed.next_node
        doomed_predecessor = find { |node| node.next_node == doomed }
        doomed_predecessor.update_next_node(doomed_successor)

        if doomed_predecessor == doomed_successor
          self.head = doomed_predecessor
        end
      end
    end
  end

  def each
    node = head
    while node
      yield(node)
      node = node.next_node
      break if node == head
    end
  end

  class Node
    attr_reader :data, :next_node

    def initialize(data, next_node = nil)
      @data = data
      @next_node = next_node || self
    end

    def update_next_node(node)
      self.next_node = node
    end

    private
    attr_writer :next_node
  end
end
