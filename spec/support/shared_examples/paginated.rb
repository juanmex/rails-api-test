# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'paginated' do
  let(:data_key) { :data }
  let(:meta_key) { :meta }
  let(:page_param) { :page }
  let(:per_page_param) { :per_page }
  before { create_records }

  def make_request(path:, params: {}, headers: {})
    get(path, params:, headers:)
    expect(response).to have_http_status(:ok)
    JSON.parse(response.body, symbolize_names: true)
  end

  it 'returns top-level data & meta keys' do
    body = make_request(path:, headers:)
    expect(body).to include(data_key, meta_key)
    expect(body[data_key]).to be_a(Array)
    expect(body[meta_key]).to be_a(Hash)
  end

  it 'includes meta keys with correct types' do
    body = make_request(path:, headers:)
    meta = body[meta_key]
    expect(meta.keys).to include(:count, :page, :pages, :per_page)
    expect(meta[:count]).to be_a(Integer)
    expect(meta[:page]).to be_a(Integer)
    expect(meta[:pages]).to be_a(Integer)
    expect(meta[:per_page]).to be_a(Integer)
  end

  context 'pagination navigation' do
    it 'returns first page with default per_page when not provided' do
      body = make_request(path:, headers:)
      meta = body[meta_key]
      expect(meta[:page]).to eq(1)
      expect(meta[:per_page]).to eq(20)
      expect(body[data_key].size).to be_between(0, meta[:per_page])
    end

    it 'returns requested page and per_page' do
      body = make_request(path:, headers:, params: { page_param => 2, per_page_param => 10 })
      meta = body[meta_key]
      expect(meta[:page]).to eq(2)
      expect(meta[:per_page]).to eq(10)
      expect(body[data_key].size).to be_between(0, 10)
    end

    it 'returns empty data for an out-of-range page but consistent meta' do
      body = make_request(path:, headers:, params: { page_param => 9999, per_page_param => 50 })
      meta = body[meta_key]
      expect(body[data_key]).to eq([])
      expect(meta[:page]).to eq(9999)
      expect(meta[:per_page]).to eq(50)
      expect(meta[:count]).to be_a(Integer)
      expect(meta[:pages]).to be >= 0
    end
  end
end
# rubocop:enable Metrics/BlockLength
