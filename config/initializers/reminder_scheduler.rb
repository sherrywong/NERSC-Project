scheduler = Rufus::Scheduler.start_new

scheduler.every '1d', :first_in => '1m' do
  for risk in Risk.all do
    Risk.notification_emailrisk_notify(risk)
  end
end


