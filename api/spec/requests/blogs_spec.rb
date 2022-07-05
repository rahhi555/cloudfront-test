# typed: true

require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  describe "GET /blogs" do
    let!(:blogs) { create_list(:blog, 10) }

    it "blogsの一覧が取得できること" do
      get blogs_path
      assert_response_schema_confirm(200)
    end
  end

  describe "GET /blogs/:id" do
    let!(:blog) { create(:blog) }

    it "blogの詳細が取得できること" do
      get blog_path(blog)
      assert_response_schema_confirm(200)
    end
  end

  describe "POST /blogs" do
    it "blogを作成できること" do
      expect do
        post blogs_path, params: { blog: { title: "test", contents: "test" } }
      end.to change(Blog, :count).by(1)
      assert_response_schema_confirm(201)
    end
  end
end
