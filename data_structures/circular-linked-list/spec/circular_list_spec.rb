require './circular_list'

RSpec.describe CircularList do
  subject { CircularList }
  let(:list) { subject.new }

  it 'expects to include Enumerable mixin' do
    expect(subject.ancestors).to include(Enumerable)
  end

  context 'when initialized' do
    it 'expects to return empty object of CircularList class' do
      expect(list).to be_an(subject)
    end
  end

  describe 'instance methods' do
    let(:populate_list) {
      ->(x) { list.insert(x) }
    }

    context '+head+' do
      it 'expects to respond to +head+ accessor' do
        expect(list.respond_to?(:head)).to eq(true)
        expect(list.respond_to?(:head=)).to eq(true)
      end

      it 'expects to return nil when no head specified' do
        expect(list.head).to eq(nil)
      end

      it 'expects to be an CircularList::Node instance when head is present' do
        populate_list.('data')
        expect(list.head).to be_an(CircularList::Node)
      end

      it 'expects to point to itself in case of single node' do
        populate_list.('data')
        expect(list.head == list.head.next_node).to eq(true)
      end
    end

    context '+search+' do
      it 'expets to respond to +search+ public instance method' do
        expect(list.respond_to?(:search)).to eq(true)
      end

      it 'expects to return nil if no head specified' do
        expect(list.search('data')).to eq(nil)
      end

      it 'expects to return CircularList::Node in case of match' do
        populate_list.('data')
        expect(list.search('data')).to be_an(CircularList::Node)
      end
    end

    context '+insert+' do
      it 'expets to respond to +insert+ public instance method' do
        expect(list.respond_to?(:insert)).to eq(true)
      end

      it 'expects to return itself after new insertion' do
        expect(list.insert('data')).to be_an(list.class)
      end

      it 'expects to manipulate pointers correctly when more than one entity' do
        %w(1 2).each &populate_list

        second_added = list.head
        first_added = list.head.next_node

        expect(first_added.next_node).to eq(second_added)

        populate_list.('3')

        third_added = list.head

        expect(first_added.next_node).to eq(third_added)
      end
    end

    context '+delete+' do
      it 'expets to respond to +delete+ public instance method' do
        expect(list.respond_to?(:delete)).to eq(true)
      end

      it 'expects to raise ArgumentError when no node specified' do
        expect { list.delete }.to raise_error(ArgumentError)
      end

      it 'expects to return itself if head deleted' do
        populate_list.('data')
        expect(list.delete(list.search('data'))).to be_an(CircularList)
      end

      it 'expects to return nil when doomed node doesn\'t exist' do
        populate_list.('data')
        doomed = list.search('data 2')
        expect(list.delete(doomed)).to eq(nil)
      end

      it 'expects to remove self-reference for head correctly' do
        populate_list.('data')
        doomed = list.search('data')
        expect(list.delete(doomed).head).to be_nil
      end

      it 'expects to create self-reference on node entity correctly' do
        %w(1 2).each &populate_list
        doomed = list.search('1')
        self_referred = list.search('2')
        expect(list.delete(doomed).head).to eq(self_referred)
      end

      it 'expects to rearrange nodes pointers correctly' do
        %w(1 2 3).each &populate_list

        doomed = list.search('2')
        list.delete(doomed)
        expect(list.map(&:data)).to eq(%w(3 1))

        populate_list.('2')

        doomed = list.search('3')
        list.delete(doomed)
        expect(list.map(&:data)).to eq(%w(2 1))
      end
    end
  end

  it 'expects to defined Node constant under CircularList namespace' do
    expect(subject.constants).to contain_exactly(:Node)
  end

  describe 'Node' do
    subject { CircularList::Node }
    let(:node) { subject.new('data') }

    it 'expects to respond to +data+ reader' do
      expect(node.respond_to?(:data)).to eq(true)
    end

    it 'expects to respond to +next_node+ reader' do
      expect(node.respond_to?(:next_node)).to eq(true)
    end

    it 'expects to respond to +update_next_node+ instance method' do
      expect(node.respond_to?(:update_next_node)).to eq(true)
    end

    context 'when initialized' do
      it 'expects to raise ArgumentError when initialized without data' do
        expect { subject.new }.to raise_error(ArgumentError)
      end

      it 'expects to return correct data when initialized with data' do
        expect(node.data).to eq('data')
      end

      it 'expects to return itself if no next node specified' do
        expect(node.next_node).to eq(node)
      end

      it 'expects to be an CircularList::Node instance if next node specified' do
        node = subject.new('data', subject.new('data 2'))
        expect(node.next_node).to be_an(CircularList::Node)
      end
    end
  end
end
