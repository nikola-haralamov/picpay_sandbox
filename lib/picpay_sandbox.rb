Dir.glob('picpay_sandbox/**/*.rb', base: __dir__).each do |filepath|
  require_relative filepath
end

module PicPaySandbox
end
