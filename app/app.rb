class App < Roda
  plugin :multi_run

  run 'payments', Routes::Payments
  run 'refunds', Routes::Refunds

  route(&:multi_run)
end
