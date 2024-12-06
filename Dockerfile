FROM ruby:3.2.2
WORKDIR /app

# Cài đặt dependencies
COPY Gemfile* ./
RUN bundle install

# Copy mã nguồn
COPY . .

# Precompile assets nếu có
RUN bundle exec rake assets:precompile

# Thiết lập command chạy Rails
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
