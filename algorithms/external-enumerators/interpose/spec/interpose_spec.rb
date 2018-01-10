require './interpose'

RSpec.describe Interpose do
  let(:subject) { described_class }

  let(:computation) do
    ->(collection, **opts) { subject.compute(collection, **opts) }
  end

  it 'expects subject to be a module' do
    expect(subject).to be_an(Module)
  end

  it 'expects subject respond to #compute method' do
    expect(subject.respond_to?(:compute)).to eq(true)
  end

  # In other words it expects to have all arguments optional
  it 'expects subject#compute arity to equal -1' do
    expect(subject.method(:compute).arity).to eq(-1)
  end

  context 'for empty collection -' do
    let(:collection) { [] }

    it 'expects to return new array' do
      result = computation.(collection)
      expect(result.object_id).not_to eq(collection.object_id)
    end

    it 'expects to return empty array' do
      result = computation.(collection)
      expect(result).to be_empty
    end
  end

  context 'for single element collection -' do
    let(:collection) { [1] }

    it 'expects to return new array' do
      result = computation.(collection)
      expect(result.object_id).not_to eq(collection.object_id)
    end

    it 'expects to return array with single element' do
      result = computation.(collection)
      expect(result).to contain_exactly(1)
    end

    it 'expects to ignore separator given from optional hash' do
      result = computation.(collection, separator: 'separator')
      expect(result).not_to include('separator')
    end
  end

  context 'for multiple elements collection -' do
    let(:collection) { [1, 2] }

    it 'expects to return new array' do
      result = computation.(collection)
      expect(result.object_id).not_to eq(collection.object_id)
    end

    it 'expects to return array with multiple elements' do
      result = computation.(collection)
      expect(result).to contain_exactly(1, nil, 2)
    end

    it 'expects to change separator given from optional hash' do
      result = computation.(collection, separator: 'separator')
      expect(result).to contain_exactly(1, 'separator', 2)
    end
  end
end
