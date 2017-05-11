FactoryGirl.define do
	factory :basic_image, class: Image do
    origin_url "http://54.152.221.29/images/b737_5.jpg"

    trait :with_formats do
      before(:create) do |object, evaluator|
        object.formats = ["http://localhost:3000/thumb/230/240/#{object._id}.jpg",
        "http://localhost:3000/thumb/384/288/#{object._id}.jpg",
        "http://localhost:3000/thumb/640/480/#{object._id}.jpg"]
      end
    end
	end
end
