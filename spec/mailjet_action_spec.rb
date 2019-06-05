describe Fastlane::Actions::MailjetAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The mailjet plugin is working!")

      Fastlane::Actions::MailjetAction.run(nil)
    end
  end
end
