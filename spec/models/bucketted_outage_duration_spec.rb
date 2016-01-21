require 'rails_helper'

describe BuckettedOutageDuration do
  subject do
    start = Time.new(2016, 01, 01, 12, 0, 0, "+01:00")
    finish = Time.new(2016, 01, 16, 23, 0, 0, "+01:00")
    described_class.new(time_period: start..finish, bucket_size: 1.day)
  end

  let(:line_id) { Line.first.id }

  describe 'fetch' do
    it 'fills an entry for each line, even without outages' do
      expect(subject.fetch.keys).to eq(Line.pluck(:id))
    end

    it 'initializes each line with empty buckets' do
      subject.fetch.values.each do |buckets|
        expect(buckets).to eq({
          1451606400 => 0,
          1451692800 => 0,
          1451779200 => 0,
          1451865600 => 0,
          1451952000 => 0,
          1452038400 => 0,
          1452124800 => 0,
          1452211200 => 0,
          1452297600 => 0,
          1452384000 => 0,
          1452470400 => 0,
          1452556800 => 0,
          1452643200 => 0,
          1452729600 => 0,
          1452816000 => 0,
          1452902400 => 0
        })
      end
    end

    it 'adds outages from the same line' do
      start_a = Time.new(2016, 01, 12, 12, 0, 0, "+01:00")
      finish_a = Time.new(2016, 01, 15, 13, 0, 0, "+01:00")
      start_b = Time.new(2016, 01, 15, 14, 0, 0, "+01:00")
      finish_b = Time.new(2016, 01, 15, 16, 0, 0, "+01:00")
      create(Outage, boundaries: start_a..finish_a, line: Line.first)
      create(Outage, boundaries: start_b..finish_b, line: Line.first)
      expect(subject.fetch[line_id]).to eq({
        1451606400 => 0,
        1451692800 => 0,
        1451779200 => 0,
        1451865600 => 0,
        1451952000 => 0,
        1452038400 => 0,
        1452124800 => 0,
        1452211200 => 0,
        1452297600 => 0,
        1452384000 => 0,
        1452470400 => 0,
        1452556800 => 46800,
        1452643200 => 86400,
        1452729600 => 86400,
        1452816000 => 50400,
        1452902400 => 0
      })
    end
  end

  it 'returns buckets rounded to the nearest start' do
    start = Time.new(2016, 01, 12, 12, 0, 0, "+01:00")
    finish = Time.new(2016, 01, 15, 13, 0, 0, "+01:00")
    create(Outage, boundaries: start..finish, line_id: line_id)
    expect(subject.fetch[line_id]).to eq({
      1451606400 => 0,
      1451692800 => 0,
      1451779200 => 0,
      1451865600 => 0,
      1451952000 => 0,
      1452038400 => 0,
      1452124800 => 0,
      1452211200 => 0,
      1452297600 => 0,
      1452384000 => 0,
      1452470400 => 0,
      1452556800 => 46800,
      1452643200 => 86400,
      1452729600 => 86400,
      1452816000 => 43200,
      1452902400 => 0
    })
  end

  it 'handles outages that started and finished within the same bucket' do
    start = Time.new(2016, 01, 12, 12, 0, 0, "+01:00")
    finish = Time.new(2016, 01, 12, 13, 0, 0, "+01:00")
    create(Outage, boundaries: start..finish, line_id: line_id)
    expect(subject.fetch[line_id]).to eq({
      1451606400 => 0,
      1451692800 => 0,
      1451779200 => 0,
      1451865600 => 0,
      1451952000 => 0,
      1452038400 => 0,
      1452124800 => 0,
      1452211200 => 0,
      1452297600 => 0,
      1452384000 => 0,
      1452470400 => 0,
      1452556800 => 3600,
      1452643200 => 0,
      1452729600 => 0,
      1452816000 => 0,
      1452902400 => 0
    })
  end

  it 'handles outages that started before the period and finish after' do
    start = Time.new(2015, 12, 31, 12, 0, 0, "+01:00")
    finish = Time.new(2016, 02, 01, 13, 0, 0, "+01:00")
    create(Outage, boundaries: start..finish, line_id: line_id)
    expect(subject.fetch[line_id]).to eq({
      1451606400 => 86400,
      1451692800 => 86400,
      1451779200 => 86400,
      1451865600 => 86400,
      1451952000 => 86400,
      1452038400 => 86400,
      1452124800 => 86400,
      1452211200 => 86400,
      1452297600 => 86400,
      1452384000 => 86400,
      1452470400 => 86400,
      1452556800 => 86400,
      1452643200 => 86400,
      1452729600 => 86400,
      1452816000 => 86400,
      1452902400 => 86400
    })
  end
end
