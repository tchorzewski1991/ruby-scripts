require './linked_list'

RSpec.describe List do
  subject { List }
  let(:list) { subject.new }

  context 'when initialized' do
    it 'expects to return empty object of List class' do
      expect(list).to be_an(subject)
    end
  end

  describe 'instance methods' do
    context '+head+' do
      it 'expects to respond to +head+ accessor' do
        expect(list.respond_to?(:head)).to eq(true)
        expect(list.respond_to?(:head=)).to eq(true)
      end

      it 'expects to return nil when no head specified' do
        expect(list.head).to eq(nil)
      end

      it 'expects to be an List::Node instance when head is present' do
        list.insert('data')
        expect(list.head).to be_an(List::Node)
      end

      it 'expects to return correct data when head is present' do
        list.insert('data')
        expect(list.head.data).to eq('data')
      end
    end

    context '+tail+' do
      it 'expets to respond to +tail+ public instance method' do
        expect(list.respond_to?(:tail)).to eq(true)
      end

      it 'expects to return head if missing additional nodes' do
        expect(list.tail).to eq(list.head)
      end

      it 'expects to return tail if nodes specified' do
        list.insert('data')
        list.insert('data 2')

        expect(list.tail.data).to eq('data')
      end
    end

    context '+search+' do
      it 'expets to respond to +search+ public instance method' do
        expect(list.respond_to?(:search)).to eq(true)
      end

      it 'expects to return nil if no head specified' do
        expect(list.search('data')).to eq(nil)
      end

      it 'expects to find and return node if data match' do
        list.insert('data')
        list.insert('data 2')

        expect(list.search('data 2')).to be_an(List::Node)
        expect(list.search('data 2').data).to eq('data 2')
      end
    end

    context '+delete+' do
      it 'expets to respond to +delete+ public instance method' do
        expect(list.respond_to?(:delete)).to eq(true)
      end

      it 'expects to raise ArgumentError when no node specified' do
        expect { list.delete }.to raise_error(ArgumentError)
      end

      it 'expects to return nil if head deleted' do
        list.insert('data')
        to_delete = list.search('data')
        list.delete(to_delete)
        expect(list.head).to eq(nil)
      end

      it 'expects to delete nodes from the middle of the list' do
        5.downto(1) { |i| list.insert(i) }
        to_delete = list.search(3)
        list.delete(to_delete)

        second_node = list.head.next_node
        third_node = second_node.next_node

        expect(third_node.data).to eq(4)
      end
    end
  end

  it 'expects to defined Node constant under List namespace' do
    expect(subject.constants).to contain_exactly(:Node)
  end

  describe 'Node' do
    subject { List::Node }
    let(:node) { subject.new('data') }

    it 'expects to respond to +data+ accessor' do
      expect(node.respond_to?(:data)).to eq(true)
    end

    it 'expects to respond to +next_node+ accessor' do
      expect(node.respond_to?(:next_node)).to eq(true)
    end

    context 'when initialized' do
      it 'expects to raise ArgumentError when initialized without data' do
        expect { subject.new }.to raise_error(ArgumentError)
      end

      it 'expects to return correct data when initialized with data' do
        expect(node.data).to eq('data')
      end

      it 'expects to return nil if no next node specified' do
        expect(node.next_node).to eq(nil)
      end

      it 'expects to be an List::Node instance if next node specified' do
        node.next_node = subject.new('next node data')
        expect(node.next_node).to be_an(List::Node)
      end
    end
  end
end
