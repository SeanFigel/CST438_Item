require 'rails_helper'
require 'pp'

RSpec.describe Item do
    subject {described_class.new(description: 'Battery', price: 3, stock: 3)}
    describe 'validations' do
        describe 'description' do
            it 'must be present' do
                expect(subject).to be_valid
                subject.description = nil
                expect(subject).to_not be_valid
                
            end
        end
        describe 'price' do
            it 'must be present' do
               expect(subject).to be_valid
               subject.price = nil
               expect(subject).to_not be_valid
            end
        end
        describe 'stock' do
            it 'must be present' do
               expect(subject).to be_valid
               subject.stock = nil
               expect(subject).to_not be_valid
            end
        end
        describe 'price' do
           it 'must be greater than 0' do
              expect(subject.price).to be > 0
              subject.price = 0
              expect(subject).to_not be > 0
           end
        end
        describe 'stock' do
           it 'must be greater than -1' do
              expect(subject.stock).to be > -1
              subject.stock = -1
              expect(subject).to_not be > -1
           end
        end
        describe 'stock' do
           it 'must be an integer' do
              expect(subject.stock).to be_kind_of(Integer) 
           end
        end
    end
end