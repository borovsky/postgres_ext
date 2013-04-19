require 'spec_helper'

describe 'Models with numeric range columns' do
  let!(:adapter) { ActiveRecord::Base.connection }

  context 'numrange' do
    context 'no default value, range' do
      before do
        adapter.create_table :rangers, :force => true do |t|
          t.numrange :best_estimate
        end
        class Ranger < ActiveRecord::Base
          attr_accessible :best_estimate
        end
      end

      after do
        adapter.drop_table :rangers
        Object.send(:remove_const, :Ranger)
      end

      describe '#create' do
        it 'creates an record when there is no assignment' do
          range = Ranger.create()
          range.reload
          range.best_estimate.should eq nil
        end

        it 'creates an record with a range' do
          range = Ranger.create( :best_estimate => 0..4)
          range.reload
          range.best_estimate.should eq 0..4
        end
      end

      describe 'range assignment' do
        it 'updates an record with an range string' do
          range = Ranger.create( :best_estimate => 0..4)
          range.best_estimate = 0...9
          range.save

          range.reload
          range.best_estimate.should eq 0...9
        end

        it 'converts empty strings to nil' do
          range = Ranger.create
          range.best_estimate = ''
          range.save

          range.reload
          range.best_estimate.should eq nil
        end
      end
    end

    context 'default value, numeric range' do
      before do
        adapter.create_table :default_rangers, :force => true do |t|
          t.numrange :best_estimate, :default => 0..5
        end
        class DefaultRanger < ActiveRecord::Base
          attr_accessible :best_estimate
        end
      end

      after do
        adapter.drop_table :default_rangers
        Object.send(:remove_const, :DefaultRanger)
      end

      describe '#create' do
        it 'creates an record when there is no assignment' do
          range = DefaultRanger.create()
          range.reload
          range.best_estimate.should eq 0..5
        end

        it 'creates an record with a range' do
          range = DefaultRanger.create( :best_estimate => 0..4)
          range.reload
          range.best_estimate.should eq 0..4
        end
      end
    end
  end
  context 'int4range' do
    context 'no default value, range' do
      before do
        adapter.create_table :int4_rangers, :force => true do |t|
          t.int4range :best_estimate
        end
        class Int4Ranger < ActiveRecord::Base
          attr_accessible :best_estimate
        end
      end

      after do
        adapter.drop_table :int4_rangers
        Object.send(:remove_const, :Int4Ranger)
      end

      describe '#create' do
        it 'creates an record when there is no assignment' do
          range = Int4Ranger.create()
          range.reload
          range.best_estimate.should eq nil
        end

        it 'creates an record with a range' do
          range = Int4Ranger.create( :best_estimate => 0..4)
          range.reload
          range.best_estimate.should eq 0...5
        end
      end

      describe 'range assignment' do
        it 'updates an record with an range string' do
          range = Int4Ranger.create( :best_estimate => 0..4)
          range.best_estimate = 0...9
          range.save

          range.reload
          range.best_estimate.should eq 0...9
        end

        it 'converts empty strings to nil' do
          range = Int4Ranger.create
          range.best_estimate = ''
          range.save

          range.reload
          range.best_estimate.should eq nil
        end
      end
    end

    context 'default value, numeric range' do
      before do
        adapter.create_table :int4_default_rangers, :force => true do |t|
          t.int4range :best_estimate, :default => 0..5
        end
        class Int4DefaultRanger < ActiveRecord::Base
          attr_accessible :best_estimate
        end
      end

      after do
        adapter.drop_table :int4_default_rangers
        Object.send(:remove_const, :Int4DefaultRanger)
      end

      describe '#create' do
        it 'creates an record when there is no assignment' do
          range = Int4DefaultRanger.create()
          range.reload
          range.best_estimate.should eq 0...6
        end

        it 'creates an record with a range' do
          range = Int4DefaultRanger.create( :best_estimate => 0..4)
          range.reload
          range.best_estimate.should eq 0...5
        end
      end
    end
  end
end
