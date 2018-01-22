require './prime_numbers'
require 'prime'

RSpec.describe PrimeNumbers do
  let(:primes) { Prime::TrialDivisionGenerator.new.first(30) }

  it 'raises exception when missing input' do
    expect { PrimeNumbers.first }.to raise_error(ArgumentError)
  end

  it 'returns correct array of prime numbers when given input' do
    expect(PrimeNumbers.first(30)).to eq(primes)
  end
end
