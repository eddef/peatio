module APIv2
  class Currencies < Grape::API

    desc 'Retrieve currencies list'
    get "/currencies" do
      present Currency.all, with: APIv2::Entities::Currency
    end

  end
end
