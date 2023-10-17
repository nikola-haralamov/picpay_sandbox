class App < Roda
  plugin :multi_run

  run 'payments', Routes::Payments
  run 'refunds', Routes::Refunds
  run 'oauth2', Routes::Auth

  route(&:multi_run)
end
