require 'av_capture'
require 'io/console'

session = AVCapture::Session.new
dev = AVCapture.devices.find(&:video?)

$stderr.puts dev.name

session.run_with(dev) do |connection|
  loop do
    case $stdin.getch
    when 'q' then break
    else
      IO.popen("open -g -f -a /Applications/Preview.app", 'w') do |f|
        f.write connection.capture
      end
    end
  end
end
